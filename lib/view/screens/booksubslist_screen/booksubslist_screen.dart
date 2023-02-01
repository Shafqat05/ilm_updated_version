import 'package:cached_network_image/cached_network_image.dart';
//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:get/get.dart';
import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../global/streamsObjects.dart';
import '../../../repository/home_repository/home_book_repository.dart';
import '../../../view_model/book_subsc_bloc/book_subsc_bloc.dart';
import '../../../view_model/book_subsc_bloc/book_subsc_event.dart';
import '../../../view_model/book_subsc_bloc/book_subsc_state.dart';
import '../../../view_model/bookmark_bloc/bookmark_bloc.dart';
import '../../../view_model/bookmark_bloc/bookmark_states.dart';
import '../../../view_model/booksubslist_bloc/booksubslist_bloc.dart';
import '../../../view_model/booksubslist_bloc/booksubslist_event.dart';
import '../../../view_model/booksubslist_bloc/booksubslist_state.dart';

class BookSubsListScreen extends StatefulWidget {
  const BookSubsListScreen({Key? key}) : super(key: key);

  @override
  State<BookSubsListScreen> createState() => _BookSubsListScreenState();
}

class _BookSubsListScreenState extends State<BookSubsListScreen> {
  BookSubsListBloc bookSubsListBloc = BookSubsListBloc(BookSubsListInitialState());
  BookMarkBloc bookMarkBloc = BookMarkBloc(BookMarkInitialState());
  BookSubscriptionBloc bookSubscriptionBloc = BookSubscriptionBloc(BookSubsInitialState());
  //BookByCatIdBloc bookByCatIdBloc = BookByCatIdBloc(BookByCatIdInitialState());

  @override
  void initState() {
    active_tab_controller.stream.listen((event) {
      if(event==2){
        bookSubsListBloc.add(BookSubsListEvent());
      }
    });
    bookSubsListBloc.add(BookSubsListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, size) {
        var height = size.maxHeight;
        var width = size.maxWidth;
        return Scaffold(
          appBar: myCustomAppBar(
            backButton: BackButton(onPressed: (){
              Navigator.pop(context);
            },),
            titleAppBar: 'My Books'.tr,
            fontSize: width * 0.045,
            context: context
          ),
          body: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: height * 0.010,
                    // ),
                    Center(
                      child: Container(
                        height: height * 0.28,
                        width: width * 0.43,
                        child: Image.asset('assets/books_img.png'),
                      ),
                    ),
                    // SizedBox(
                    //   height: height * 0.010,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.060,right: width * 0.060),
                      child: Row(
                        children: [
                          Text(
                            'All Subscribe Books'.tr,
                            style: TextStyle(
                                fontSize: width * 0.05,
                                color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.70) : AppColors.whiteColor),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.all(20),
                        height: height * 0.45,
                        child:  BlocBuilder<BookSubsListBloc, BookSubsListState>(
                          bloc: bookSubsListBloc,
                          builder: (context, state) {
                            if(state is BookSubsListLoadedState){
                              return ListView.builder(
                                  itemCount: state.response.data!.length,
                                  itemBuilder: (context, index) {
                                    if(state.response != null){
                                      return Container(
                                        margin: EdgeInsets.all(17),
                                       // height: height * 0.21,
                                        width: width * 0.26,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors.allButtonColor
                                                    .withOpacity(0.14),
                                                offset: Offset(2, 4),
                                                blurRadius: 5,
                                                spreadRadius: 2)
                                          ],
                                          borderRadius: BorderRadius.circular(13),
                                          color: Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.blackColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(15),
                                              height: height * 0.15,
                                              width: width * 0.23,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                '$imagecatagories' +
                                                    '${state.response.data![index].bookCoverImage}',
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                      'assets/ilam_ur.png',
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                              // Image.network(

                                              //   fit: BoxFit.cover,

                                              // ),
                                            ),
                                            Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: height * 0.020),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async{
                                                              state.response.data![index].subBookid == '0';
                                                              bookSubscriptionBloc.add(BookSubscriptionEvent(
                                                                  bookId: ''
                                                              ));
                                                              await HomeBookRepository().bookSubscriptionApi(bookId: state.response.data![index].subBookid);
                                                              setState(() {
                                                                bookSubsListBloc.add(BookSubsListEvent(
                                                                    subsBookId: state.response.data![index].subBookid
                                                                ));
                                                              });

                                                            },
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: AppColors
                                                                        .allButtonColor,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        18)),
                                                                margin: EdgeInsets.only(
                                                                    right: 10,left: 10),
                                                                height: height * 0.040,
                                                                width: width * 0.16,
                                                                child: Center(
                                                                    child: Text(
                                                                      'Remove'.tr,
                                                                      style: TextStyle(
                                                                          color:
                                                                          Colors.white,
                                                                          fontSize: width * 0.035),
                                                                    ))),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          SizedBox(
                                                            height: height * 0.006,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${state.response.data![index].bookName}',
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  style: TextStyle(
                                                                      color: AppColors
                                                                          .allButtonColor,
                                                                      fontSize: width * 0.035,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:  EdgeInsets.all(4),
                                                                child: Text(
                                                                  '${state.response.data![index].subAddedate}',
                                                                  style: TextStyle(
                                                                      fontSize: width * 0.038,
                                                                      color:
                                                                      Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.60) : AppColors.textColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),

                                                          SizedBox(
                                                            height: height * 0.020,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  'Access now All Books Solution'.tr,
                                                                  style: TextStyle(
                                                                      fontSize: width * 0.038,
                                                                      color: AppColors
                                                                          .allButtonColor,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.013,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      );
                                    }
                                    else{
                                      return Container(child: Text('No Data'.tr),);
                                    }
                                  });
                            }
                            else if(state is BookSubsListLoadingState){
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
                                BoxDecoration(color:Theme.of(context).brightness == Brightness.light? Colors.white:AppColors.blackColor),
                              );;
                            }
                            else{
                              return Text('');
                            }
                          },
                        ),

                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
