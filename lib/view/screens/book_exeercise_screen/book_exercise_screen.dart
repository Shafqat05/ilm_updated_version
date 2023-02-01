//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:ilm_updated_version/main.dart';
import 'package:ilm_updated_version/view_model/bookmark_list_bloc/bookmark_list_event.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:ilm_updated_version/models/book_chapter_model/book_chapter_behaviour.dart';
import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../models/book_exercise_model/book_exercise_get_model.dart';
import '../../../view_model/book_exercise_bloc/book_exercise_bloc.dart';
import '../../../view_model/book_exercise_bloc/book_exercise_event.dart';
import '../../../view_model/book_exercise_bloc/book_exercise_state.dart';
import '../../../view_model/bookmark_bloc/bookmark_bloc.dart';
import '../../../view_model/bookmark_bloc/bookmark_event.dart';
import '../../../view_model/bookmark_bloc/bookmark_states.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_bloc.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_state.dart';
import '../../../view_model/chapter_info_bloc/chapter_info_bloc.dart';
import '../../../view_model/chapter_info_bloc/chapter_info_event.dart';
import '../../../view_model/chapter_info_bloc/chapter_info_state.dart';
import '../../../view_model/exercise_info_bloc/exer_info_bloc.dart';
import '../../../view_model/exercise_info_bloc/exer_info_event.dart';
import '../../../view_model/exercise_info_bloc/exer_info_state.dart';
import '../chapter_info_screen/chapter_info_screen.dart';
import '../choose_subscription/choose_subscription.dart';

class BookExerciseScreen extends StatefulWidget {
  final String? image;
  final String? bookName;
  final String? isbn;
  final String? bookAuthor;
  final String? getChapId;
  late dynamic? bookMark;
  final String? bookId;
  final String? chapterNum;
  final String? chapterName;
  BookExerciseScreen(
      {Key? key,
      this.image,
      this.bookName,
      this.isbn,
      this.bookAuthor,
      this.getChapId,
      this.bookMark,
      this.chapterName,
      this.bookId,
      this.chapterNum})
      : super(key: key);

  @override
  State<BookExerciseScreen> createState() => _BookExerciseScreenState();
}

class _BookExerciseScreenState extends State<BookExerciseScreen> {
  BookExerciseBloc bookExerciseBloc =
      BookExerciseBloc(BookExerciseInitialState());
  BookMarkBloc bookMarkBloc = BookMarkBloc(BookMarkInitialState());
  ExerciseInfoBloc exerciseInfoBloc = ExerciseInfoBloc(ExerInfoInitialState());
  ChapterInfoBloc chapterInfoBloc = ChapterInfoBloc(ChpInfoInitialState());
  bool selected = true;
  bool isHide = true;

  @override
  void initState() {
    bookExerciseBloc.add(BookExerciseEvent(chapId: widget.getChapId));
    chapterInfoBloc
        .add(ChapterInfoEvent(id: widget.getChapId, chpNum: widget.chapterNum));
    print('chapter id ${widget.getChapId}');
    print('chapter num id ${widget.chapterNum}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, size) {
        var height = size.maxHeight;
        var width = size.maxWidth;
        return Scaffold(
          appBar: isHide
         ? myCustomAppBar(
            titleAppBar: 'Book Exercise'.tr,
            fontSize: width * 0.045,
            context: context,
            //heightFactor: height * 0.0,
            //widthFactor: width * 0.03,
            backButton: BackButton(
              color: AppColors.allButtonColor,

            ),
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
                  Column(
                    children: [
                      Container(
                        //margin: EdgeInsets.only(left: width * 0.03),
                        //height: height * 0.17,
                        width: width * 0.95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.allButtonColor.withOpacity(0.14),
                                  offset: Offset(4, 6),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor),
                        child: Column(
                          children: [
                            BlocBuilder<ChapterInfoBloc, ChapterInfoState>(
                              bloc: chapterInfoBloc,
                              builder: (context, state) {
                                if (state is ChpInfoLoadedState) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.010,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: height * 0.006),
                                        height: height * 0.14,
                                        width: width * 0.15,
                                        child: Image.network(
                                          '$baseImageUrl' +
                                              '${state.response.bookCoverImage}',
                                        ),
                                      ),
                                      SizedBox(width: width * 0.030),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          SizedBox(
                                            height: height * 0.013,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${state.response.bookName}',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: width * 0.035,
                                                      color:
                                                          AppColors.allButtonColor,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              Row(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Image.asset(
                                                  //     'assets/bookmark.png'),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          'book mark ====== ${state.response.bookmarked}');
                                                      if(storage.hasData('token')){
                                                        bookMarkBloc
                                                            .homeBookRepository
                                                            .bookMarksApi(
                                                            context: context,
                                                            chapId: state
                                                                .response.cId,
                                                            exId: '0',
                                                            bookId: '0',
                                                            bookMarkId: state
                                                                .response
                                                                .bookmarked
                                                                .toString() ==
                                                                '1'
                                                                ? '0'
                                                                : '1',
                                                            quesNum: '0',
                                                            exNum: '0',
                                                            chpteNum: state
                                                                .response
                                                                .cNumber);

                                                        if (state.response
                                                            .bookmarked ==
                                                            '1') {
                                                          setState(() {
                                                            state.response
                                                                .bookmarked = '0';
                                                          });
                                                        } else {
                                                          setState(() {
                                                            state.response
                                                                .bookmarked = '1';
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
                                                              '1'
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                      size: width * 0.06,
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.020),
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
                                            children: [
                                              Text(
                                                'Chapter ${state.response.cId}'.tr,
                                                // 'Chapter ${exinfocontroller.exrInfoBookValue['c_number']}',
                                                style: TextStyle(
                                                    fontSize: width * 0.035,
                                                    color: AppColors.allButtonColor,
                                                    fontWeight: FontWeight.bold),
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
                                                    top: 3, right: 22,left: 22),
                                                child: Text(
                                                  '${state.response.bookAuthor}',
                                                  // '${exinfocontroller.exrInfoBookValue['book_author']}',
                                                  style: TextStyle(
                                                      fontSize: width * 0.035,
                                                  //    color: Colors.black.withOpacity(0.40)
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'ISBN:'.tr,
                                                style: TextStyle(
                                                    color: AppColors.allButtonColor,
                                                    fontSize: width * 0.04,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: width * 0.030,
                                              ),
                                              Text(
                                                '${state.response.bookIsbn}',
                                                // '${exinfocontroller.exrInfoBookValue['book_isbn']}',
                                                style: TextStyle(
                                                  fontSize: width * 0.035,
                                                   // color: Colors.black.withOpacity(0.40)
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: Text(' '),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: height*0.020,
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  Expanded(
                    child: BlocBuilder<BookExerciseBloc, BookExerciseState>(
                      bloc: bookExerciseBloc,
                      builder: (context, state) {
                        if (state is BookExerciseLoadedState) {
                          return BookExScreen(context, state.response);
                        } else if (state is BookExerciseLoadingState) {
                          return Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: SpinKitFadingCircle(
                              size: 50,
                              color: AppColors.circlepicker,
                            )),
                            decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.light? Colors.white:AppColors.blackColor),
                          );
                        } else {
                          return Center(
                            child: Text('No Data'.tr),
                          );
                        }
                      },
                    ),
                  ),
                ],
              )),
            ],
          ),

        );
      }),
    );
  }

  Widget BookExScreen(
      BuildContext context, BookExerciseGetModel bookExerciseGetModel) {
    return LayoutBuilder(builder: (context, size) {
      var height = size.maxHeight;
      var width = size.maxWidth;
      return ListView.builder(
          itemCount: bookExerciseGetModel.data!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: height * 0.020,
                ),
                InkWell(
                  onTap: () {
                    pushNewScreen(
                      context,
                      screen: ChapterInfoScreen(
                        getChapterId:
                            '${bookExerciseGetModel.data![index].chapId}',
                        markId: bookExerciseGetModel.data![index].bookmarked
                            .toString(),
                        exNum: '${bookExerciseGetModel.data![index].execNum}',
                        quesNum:
                            '${bookExerciseGetModel.data![index].questNum}',
                        bookId: '${bookExerciseGetModel.data![index].bookId}',
                        exId: '${bookExerciseGetModel.data![index].execId}',
                        chpNum: widget.chapterNum,
                        image:widget.image
                      ),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                  child: Container(
                    //margin: EdgeInsets.only(left: 8),
                    height: height * 0.078,
                    width: width * 0.94,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            'Exercise'.tr + '${bookExerciseGetModel.data![index].execId}',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.whiteColor
                            ),
                            // 'Exercise ${exinfocontroller.exrInfoBookValue['exec_id']}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 07,left: 7),
                          child: Image.asset(
                            'assets/arrow.png',
                            height: height * 0.04,
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.allButtonColor.withOpacity(0.14),
                              offset: Offset(2, 6),
                              blurRadius: 5,
                              spreadRadius: 2),
                        ],
                        color: Theme.of(context).brightness == Brightness.light? AppColors.whiteColor:AppColors.blackColor),
                  ),
                ),
              ],
            );
          });
    });
  }
}

// Widget Screen() {
//   return Row(
//     children: [
//       SizedBox(
//         width: width * 0.010,
//       ),
//       Container(
//         margin: EdgeInsets.only(top: 10),
//         height: height * 0.10,
//         width: width * 0.15,
//         child: Image.network(
//           '$baseImageUrl' + '${state.response.bookCoverImage}',
//         ),
//       ),
//       SizedBox(width: width * 0.030),
//       Expanded(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: height * 0.013,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '${state.response.bookName}',
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontSize: 13,
//                           color:
//                           AppColors.allButtonColor,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   Row(
//                     // mainAxisAlignment:
//                     //     MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Image.asset(
//                       //     'assets/bookmark.png'),
//                       GestureDetector(
//                         onTap: (){
//                           print('book mark ====== ${state.response.bookmarked}');
//                           bookMarkBloc.homeBookRepository
//                               .bookMarksApi(
//                               context: context,
//                               chapId: state.response.cId,
//                               exId: '0',
//                               bookId: state.response
//                                   .bId,
//                               bookMarkId: state
//                                   .response
//                                   .bookmarked.toString()== '1'?'0':'1',
//                               quesNum: '0',
//                               exNum: '0',
//                               chpteNum: state.response.cNumber);
//                           // bookMarkBloc.add(BookMarkEvent(bookId: state.response.bId, bookMarkId: state.response.bookmarked.toString() == '1' ? '0' : '1', exId: '0', chapId: state.response.cId, chpteNum: state.response.cNumber, exNum: '0', quesNum: '0'));
//                           if (state.response
//                               .bookmarked ==
//                               1) {
//                             setState(() {
//                               state.response
//                                   .bookmarked =
//                               0;
//                             });
//                           } else {
//                             setState(() {
//                               state.response
//                                   .bookmarked =
//                               1;
//                             });
//                           }
//                           setState(() {});
//                         },
//                         child: Icon(
//                           Icons.bookmark,
//                           color: state.response.bookmarked == 1 ? Colors.blue : Colors.grey,
//                         ),
//                       ),
//                       SizedBox(width: width * 0.020),
//                       Image.asset(
//                         'assets/fullscreen.png',
//                         cacheHeight: 20,
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     width: width * 0.040,
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Chapter ${
//                         state.response.cId
//                     //bookExerciseController.bookExrList[0].chapId
//                     }',
//                     // 'Chapter ${exinfocontroller.exrInfoBookValue['c_number']}',
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: AppColors.allButtonColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Author :',
//                     style: TextStyle(
//                         fontSize: 12,
//                         color: AppColors.allButtonColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         top: 3, right: 22),
//                     child: Text(
//                       '${state.response.bookAuthor}',
//                       // '${exinfocontroller.exrInfoBookValue['book_author']}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black
//                               .withOpacity(0.40)),
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'ISBN:',
//                     style: TextStyle(
//                         color: AppColors.allButtonColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     width: width * 0.030,
//                   ),
//                   Text(
//                     '${state.response.bookIsbn}',
//                     // '${exinfocontroller.exrInfoBookValue['book_isbn']}',
//                     style: TextStyle(
//                         color: Colors.black
//                             .withOpacity(0.40)),
//                   ),
//                 ],
//               )
//             ],
//           ))
//     ],
//   );
// }
