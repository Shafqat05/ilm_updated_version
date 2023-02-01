import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:ilm_updated_version/main.dart';
import 'package:ilm_updated_version/view_model/book_ex_ques_bloc/book_ex_ques_event.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../models/chapter_exercise_model/chapter_ex_get_model.dart';
import '../../../models/chapter_info/chapter_info_get_model.dart';
import '../../../models/exercise_info_model/exercise_info_model.dart';
import '../../../view_model/book_ex_ques_bloc/book_ex_ques_bloc.dart';
import '../../../view_model/book_ex_ques_bloc/book_ex_question_state.dart';
import '../../../view_model/bookmark_bloc/bookmark_bloc.dart';
import '../../../view_model/bookmark_bloc/bookmark_states.dart';
import '../../../view_model/chapter_exercise_bloc/chapter_exercise_bloc.dart';
import '../../../view_model/chapter_exercise_bloc/chapter_exercise_event.dart';
import '../../../view_model/chapter_exercise_bloc/chapter_exercise_states.dart';
import '../../../view_model/chapter_info_bloc/chapter_info_bloc.dart';
import '../../../view_model/chapter_info_bloc/chapter_info_event.dart';
import '../../../view_model/chapter_info_bloc/chapter_info_state.dart';
import '../../../view_model/exercise_info_bloc/exer_info_bloc.dart';
import '../../../view_model/exercise_info_bloc/exer_info_event.dart';
import '../../../view_model/exercise_info_bloc/exer_info_state.dart';
import '../book_ex_ques_screen/book_ex_ques_screen.dart';
import '../chapter_exercise_screen/chapter_exercise_screen.dart';

class ChapterInfoScreen extends StatefulWidget {
  final String? getChapterId;
  late String? markId;
  final String? exNum;
  final String? quesNum;
  final String? bookId;
  final String? exId;
  final String? chpNum;
  final String? image;
  ChapterInfoScreen({
    Key? key,
    this.chpNum,
    this.image,
    this.getChapterId,
    this.markId,
    this.bookId,
    this.quesNum,
    this.exNum,
    this.exId,
  }) : super(key: key);

  @override
  State<ChapterInfoScreen> createState() => _ChapterInfoScreenState();
}

class _ChapterInfoScreenState extends State<ChapterInfoScreen> {
  ChapterInfoBloc chapterInfoBloc = ChapterInfoBloc(ChpInfoInitialState());

  BookExQuestionBloc bookExQuestionBloc =
      BookExQuestionBloc(BookExQuesInitialState());
  bool selected = true;
  bool isHide = true;
  BookMarkBloc bookMarkBloc = BookMarkBloc(BookMarkInitialState());
  ExerciseInfoBloc exerciseInfoBloc = ExerciseInfoBloc(ExerInfoInitialState());

 // ChapterExerciseBloc chapterExerciseBloc = ChapterExerciseBloc(ChapterExInitialState());

  @override
  void initState() {
   // chapterExerciseBloc.add(ChapterExEvent(id: widget.exId));
    chapterInfoBloc.add(ChapterInfoEvent(id: widget.getChapterId));
    // bookExQuestionBloc.add(BookExQuestionEvent());
    exerciseInfoBloc.add(ExerInfoEvent(
        exId: widget.exId, chpId: widget.getChapterId, bookId: widget.bookId));
    print('chapter id ${widget.getChapterId}');
    print('exercise id ${widget.exId}');
    print('book id ${widget.bookId}');
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
                titleAppBar: 'Chapter Info'.tr,
                context: context,
                fontSize: width * 0.04)
            : PreferredSize(
                child: SizedBox(), preferredSize: Size.fromHeight(0)),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.030,
                  ),

                  BlocBuilder<ExerciseInfoBloc, ExerciseInfoState>(
                    bloc: exerciseInfoBloc,
                    builder: (context, state) {
                      if (state is ExerInfoLoadedState) {
                        return Container(
                          // height: height * 0.14,
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
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.020,
                                  ),
                                  Container(
                                    height: height * 0.12,
                                    width: width * 0.16,
                                    child: Image.network(
                                      '$baseImageUrl' +
                                          '${state.response.bookCoverImage}',
                                    ),
                                  ),
                                  SizedBox(width: width * 0.030),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${state.response.chapterName}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: width * 0.038,
                                                    color: AppColors
                                                        .allButtonColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.020,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
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
                                                             .response
                                                             .chapId,
                                                         exId: state.response
                                                             .execId,
                                                         bookId: state
                                                             .response
                                                             .bookId,
                                                         bookMarkId: state
                                                             .response
                                                             .bookmarked
                                                             .toString() ==
                                                             '1'
                                                             ? '0'
                                                             : '1',
                                                         quesNum: '0',
                                                         exNum: '0',
                                                         chpteNum: '0');

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
                                                    size: width * 0.058,
                                                    color: state.response
                                                                .bookmarked ==
                                                            '1'
                                                        ? Colors.blue
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: width * 0.030,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width * 0.04,left: width * 0.04),
                                              child: Row(
                                                children: [
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
                                                            height:
                                                                height * 0.027,
                                                      color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.textColor,

                                                      //cacheHeight: 18,
                                                          )
                                                        : Icon(
                                                            Icons.zoom_out_map,
                                                      color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.textColor,

                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Chapter'.tr +'${state.response.chapId}',
                                              // 'Chapter ${controller.exrInfoBookValue['c_number']}, ',
                                              style: TextStyle(
                                                fontSize: width * 0.038,
                                                color: AppColors.allButtonColor,
                                              ),
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
                                                  color:
                                                      AppColors.allButtonColor,
                                                  fontSize: width * 0.04
                                                  //fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(
                                              width: width * 0.010,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width * 0.060,left: width * 0.060),
                                              child: Text(
                                                '${state.response.bookAuthor}',
                                                style: TextStyle(
                                                   // color: Colors.black.withOpacity(0.40),
                                                    fontSize: width * 0.04),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(),
                                        Row(
                                          children: [
                                            Text(
                                              'ISBN:'.tr,
                                              style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  color:
                                                      AppColors.allButtonColor),
                                            ),
                                            SizedBox(
                                              width: width * 0.030,
                                            ),
                                            Text(
                                              '${state.response.bookIsbn}',
                                              style: TextStyle(
                                                  fontSize: width * 0.04,
                                                 // color: Colors.black.withOpacity(0.40)
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: height * 0.005,
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: Text(''),
                        );
                      }
                    },
                  ),

                  SizedBox(
                    height: height * 0.040,
                  ),

                  // Get.to(BookingDetailStepWisePage());
                  Expanded(
                    child:
                        BlocConsumer<ExerciseInfoBloc, ExerciseInfoState>(
                      bloc: exerciseInfoBloc,
                      builder: (context, state) {
                        if (state is ExerInfoLoadedState) {
                          return ChpInfoUi(context, state.response);
                        } else if (state is ExerInfLoadingState) {
                          return Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: SpinKitFadingCircle(
                              size: 50,
                              color: AppColors.circlepicker,
                            )),
                            decoration: BoxDecoration(color: Theme.of(context).brightness == Brightness.light? Colors.white:AppColors.blackColor),
                          );
                        } else {
                          return Container(
                            child: Text(''),
                          );
                        }
                      },
                      listener: (context, state) {},
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ChpInfoUi(BuildContext context, ExerciseInfoGetModel exerciseInfoGetModel) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        InkWell(
          onTap: () {
            pushNewScreen(
              context,
              screen: ChapterExerciseScreen(
                getImage: '${widget.image}',
                getExerciseId: '${widget.exId}',
              ),

              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.fade,
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: width * 0.020, right: width * 0.020),
            height: height * 0.070,
            width: width * 0.88,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.8,
                    spreadRadius: 0.8,
                    color: Colors.greenAccent.withOpacity(0.08),
                    offset: Offset(1, 4),
                  ),
                ],
                color: Theme.of(context).brightness == Brightness.light? AppColors.whiteColor:AppColors.blackColor),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.015),
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Text(
                    'Q ${exerciseInfoGetModel.execId}. ${exerciseInfoGetModel.questInfo}',
                    style: TextStyle(fontSize: width * 0.042,color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.whiteColor),
                  )),
                  Image.asset(
                    'assets/arrow.png',
                    height: height * 0.06,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.030,
        ),
        // InkWell(
        //   onTap: () {
        //     pushNewScreen(
        //       context,
        //       screen: BookExQuestionScreen(
        //         getImage: '${widget.image}',
        //         chpId: '${widget.getChapterId}',
        //         exId: '${widget.exId}',
        //       ),
        //       withNavBar: true, // OPTIONAL VALUE. True by default.
        //       pageTransitionAnimation: PageTransitionAnimation.fade,
        //     );
        //   },
        //   child: Container(
        //     margin: EdgeInsets.only(left: width * 0.020, right: width * 0.020),
        //     height: height * 0.070,
        //     width: width * 0.88,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(6),
        //         boxShadow: [
        //           BoxShadow(
        //             blurRadius: 5,
        //             spreadRadius: 2,
        //             color: Colors.greenAccent.withOpacity(0.08),
        //             offset: Offset(2, 4),
        //           ),
        //         ],
        //         color: Theme.of(context).brightness == Brightness.light? AppColors.whiteColor:AppColors.blackColor),
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: width * 0.015),
        //       child: Row(
        //         children: [
        //           Expanded(
        //               child: Text(
        //             'Q2. 2nd Question of Ex 1',
        //             style: TextStyle(fontSize: width * 0.042),
        //           )),
        //           Image.asset(
        //             'assets/arrow.png',
        //             height: height * 0.06,
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}

// ListView.builder(
// itemCount: chapterExGetModel.data!.length,
// itemBuilder: (context, index) {
// return Column(
// children: [
// InkWell(
// onTap: () {
// pushNewScreen(
// context,
// screen: ChapterExerciseScreen(
// getImage:
// widget.image,
// getExerciseId:
// '${widget.exId}',
// ),
//
// withNavBar:
// true, // OPTIONAL VALUE. True by default.
// pageTransitionAnimation:
// PageTransitionAnimation.fade,
// );
// },
// child: Container(
// margin: EdgeInsets.only(
// left: width * 0.020,
// right: width * 0.020),
// height: height * 0.070,
// width: width * 0.88,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(6),
// boxShadow: [
// BoxShadow(
// blurRadius: 0.8,
// spreadRadius: 0.8,
// color: Colors.greenAccent
//     .withOpacity(0.08),
// offset: Offset(1, 4),
// ),
// ],
// color: Colors.white),
// child: Padding(
// padding: EdgeInsets.symmetric(
// horizontal: width * 0.015),
// child: Row(
// // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Expanded(
// child: Text(
// 'Q No${chapterExGetModel.data![index].questNum}. ${chapterExGetModel.data![index].questInfo}',
// style: TextStyle(fontSize: width * 0.042),
// )),
// Image.asset(
// 'assets/arrow.png',
// height: height * 0.06,
// )
// ],
// ),
// ),
// ),
// ),
// ],
// );
// },
// );
