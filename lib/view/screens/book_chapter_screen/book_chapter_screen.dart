import 'package:cached_network_image/cached_network_image.dart';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:ilm_updated_version/view_model/bookbycatid_bloc/bookbycatid_states.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get/get.dart';
import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../main.dart';
import '../../../models/book_chapter_model/book_chapter_behaviour.dart';
import '../../../models/book_chapter_model/book_chapter_get_model.dart';
import '../../../repository/home_repository/home_book_repository.dart';
import '../../../view_model/book_chapter_bloc/book_chapter_bloc.dart';
import '../../../view_model/book_chapter_bloc/book_chapter_event.dart';
import '../../../view_model/book_chapter_bloc/book_chapter_state.dart';
import '../../../view_model/book_info_bloc/book_info_bloc.dart';
import '../../../view_model/book_info_bloc/book_info_event.dart';
import '../../../view_model/book_info_bloc/book_info_state.dart';
import '../../../view_model/bookmark_bloc/bookmark_bloc.dart';
import '../../../view_model/bookmark_bloc/bookmark_event.dart';
import '../../../view_model/bookmark_bloc/bookmark_states.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_bloc.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_event.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_state.dart';
import '../book_exeercise_screen/book_exercise_screen.dart';

class BookChapterScreen extends StatefulWidget {
  final String? bookId;
  final String? getBookImg;
  final String? bookName;
  final String? author;
  final String? bookIsbn;
  final String? bookMark;
  const BookChapterScreen(
      {Key? key,
      this.bookId,
      this.getBookImg,
      this.bookName,
      this.author,
      this.bookIsbn,
      this.bookMark})
      : super(key: key);

  @override
  State<BookChapterScreen> createState() => _BookChapterScreenState();
}

class _BookChapterScreenState extends State<BookChapterScreen>
    with BookChapterBehaviour {
  bool isHide = true;
  BookChapterBloc bookChapterBloc = BookChapterBloc(BookChapterInitialState());
  BookMarkBloc bookMarkBloc = BookMarkBloc(BookMarkInitialState());
  BookInfoBloc bookInfoBloc = BookInfoBloc(BookInfoInitialState());
  bool selected = true;
  bool _value = false;
  ThemeMode themeMode = ThemeMode.system;

  // ThemeData themeData = ThemeData();


  @override
  void initState() {
    bookChapterBloc.add(BookChapterEvent(chapterId: widget.bookId));
    bookInfoBloc.add(BookInfoEvent(bookId: widget.bookId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: isHide
          ? myCustomAppBar(
              backButton: BackButton(
                color: AppColors.allButtonColor,
              ),
              titleAppBar: 'Book Chapter'.tr,
        fontSize: width * 0.045,
        context: context
            )
          : PreferredSize(child: SizedBox(), preferredSize: Size.fromHeight(0)),
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.030,
                ),
                Container(
                  height: height * 0.13,
                  width: width * 0.95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.allButtonColor
                                .withOpacity(0.14),
                            offset: Offset(4, 6),
                            blurRadius: 5,
                            spreadRadius: 2)
                      ],
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor),
                  child: Column(
                    children: [
                      BlocBuilder<BookInfoBloc, BookInfoState>(
                          bloc: bookInfoBloc,
                          builder: (context, state) {
                            if(state is BookInfoLoadedState){
                              return Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.010,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 14),
                                    height: height * 0.090,
                                    width: width * 0.15,
                                    child: CachedNetworkImage(
                                      imageUrl: '$baseImageUrl' +
                                          '${state.response.bookCoverImage}',
                                      placeholder: (context, url) => Image.asset(
                                        'assets/ilam_ur.png',
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.fill,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.010),
                                  Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${state.response.bookName

                                                  // bookChapterController.bookChapterIdList[0].bookName
                                                  }',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: width * 0.035,
                                                      color: AppColors.allButtonColor,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      print('book mark ====== ${state.response.bookmarked}');
                                                      if(storage.hasData('token')){
                                                        bookMarkBloc.homeBookRepository
                                                            .bookMarksApi(
                                                            context: context,
                                                            chapId: '0',
                                                            exId: '0',
                                                            bookId: state.response
                                                                .bId,
                                                            bookMarkId: state
                                                                .response
                                                                .bookmarked ==
                                                                '1'
                                                                ? '0'
                                                                : '1',
                                                            quesNum: '0',
                                                            exNum: '0',
                                                            chpteNum: '0');

                                                        if (state.response
                                                            .bookmarked ==
                                                            1.toString()) {
                                                          setState(() {
                                                            state.response
                                                                .bookmarked =
                                                                0.toString();
                                                          });
                                                        } else {
                                                          setState(() {
                                                            state.response
                                                                .bookmarked =
                                                                1.toString();
                                                          });
                                                        }
                                                        setState(() {});
                                                      }
                                                      else{
                                                        showToast(
                                                            'Login First'.tr,
                                                            context: context,
                                                            animation: StyledToastAnimation.fade,
                                                            curve: Curves.linear,
                                                            reverseCurve: Curves.linear);
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.bookmark,
                                                      color: state.response
                                                          .bookmarked ==
                                                          1.toString()
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                      size: width * 0.055,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.020,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (isHide) {
                                                        setState(() {
                                                          isHide = false;
                                                        });
                                                        enterFullScreen(
                                                          FullScreenMode
                                                              .EMERSIVE_STICKY,
                                                        );
                                                      } else {
                                                        setState(() {
                                                          isHide = true;
                                                        });
                                                        exitFullScreen();
                                                      }
                                                    },
                                                    child: isHide
                                                        ? Image.asset(
                                                      'assets/fullscreen.png',
                                                     // cacheHeight: 18,
                                                      height: height * 0.027,
                                                      color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.textColor,
                                                    )
                                                        : Icon(
                                                        Icons.zoom_out_map,
                                                      color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.textColor,

                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: width * 0.040,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Author:'.tr,
                                                style: TextStyle(
                                                    fontSize: width * 0.035,
                                                    color: AppColors.allButtonColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20, top: 3,left: 20),
                                                child: Text(
                                                  '${state.response.bookAuthor
                                                  // bookChapterController.bookChapterIdList[0].bookAuthor

                                                  }',
                                                  style: TextStyle(fontSize: width * 0.035,),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.008,),
                                          Row(
                                            children: [
                                              Text(
                                                'ISBN:'.tr,
                                                style: TextStyle(
                                                    color: AppColors.allButtonColor,
                                                    fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.04,
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.030,
                                              ),
                                              Text(
                                                  '${state.response.bookIsbn}',
                                                style: TextStyle(
                                                  fontSize: width * 0.04,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                ],
                              );
                            }
                            else{
                              return Center(child: Text(''),);
                            }
                          },),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.020,
                ),
                Expanded(
                  child: BlocBuilder<BookChapterBloc, BookChapterStates>(
                    bloc: bookChapterBloc,
                    builder: (context, state) {
                      if(state is BookChapterLoadedState){
                        return BookChapScreen(context, state.response);
                      }
                      else if(state is BookChapterLoadingState){
                        return Container(
                          height: height,
                          width: width,
                          child:
                          Center(
                              child: SpinKitFadingCircle(
                                size: 50,
                                color: AppColors.circlepicker,
                              )
                          ),
                          decoration:
                          BoxDecoration(color: Theme.of(context).brightness == Brightness.light? Colors.white:AppColors.blackColor),
                        );
                      }
                      else{
                        return Text(' ');
                      }
                    },
                  ),
                ),
              ],
            ),
          )
          //  ),
        ],
      ),
    ));
  }

  Widget BookChapScreen(
      BuildContext context, BookChapterGetModel bookChapterGetModel) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: bookChapterGetModel.data!.length,
        itemBuilder: (context, index) {
          if (bookChapterGetModel != null) {
            return InkWell(
              onTap: () {
                pushNewScreen(
                  context,
                  screen: BookExerciseScreen(
                    image: '${widget.getBookImg}',
                    bookName: '${bookChapterGetModel.data![index].bookName
                        // bookChapterController.bookChapterIdList[index].bookName
                        }',
                    bookAuthor: '${bookChapterGetModel.data![index].bookAuthor
                        //  bookChapterController.bookChapterIdList[index].bookAuthor
                        }',
                    isbn: '${bookChapterGetModel.data![index].bookIsbn

                        //  bookChapterController.bookChapterIdList[index].bookIsbn
                        }',
                    getChapId: '${bookChapterGetModel.data![index].cId

                        // bookChapterController.bookChapterIdList[index].cId
                        }',
                    bookMark: bookChapterGetModel.data![index].bookmarked,
                    bookId: '${bookChapterGetModel.data![index].bId

                        // bookChapterController.bookChapterIdList[index].cId
                        }',
                    chapterNum: '${bookChapterGetModel.data![index].cNumber

                        // bookChapterController.bookChapterIdList[index].cId
                        }',
                    chapterName: '${bookChapterGetModel.data![index].chapterName

                        // bookChapterController.bookChapterIdList[index].cId
                        }',
                  ),

                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.020,
                  ),
                  Container(
                    height: height * 0.080,
                    width: width * 0.93,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                              '${bookChapterGetModel.data![index].chapterName}',
                            style: TextStyle(fontSize: width * 0.04,color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.whiteColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 07,left: 7),
                          child: Image.asset('assets/arrow.png',
                            height: height * 0.03,
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.allButtonColor.withOpacity(0.14),
                              offset: Offset(4, 6),
                              blurRadius: 5,
                              spreadRadius: 2),
                        ],
                        color: Theme.of(context).brightness == Brightness.light? AppColors.whiteColor:AppColors.blackColor),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              child: Text('fggdggg'),
            );
          }
        });
  }
}