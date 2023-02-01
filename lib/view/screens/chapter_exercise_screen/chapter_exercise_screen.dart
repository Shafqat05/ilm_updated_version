import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:ilm_updated_version/main.dart';
import 'package:ilm_updated_version/view_model/addcomment_bloc/addcomment_event.dart';
import 'package:ilm_updated_version/view_model/addcomment_bloc/addcomment_state.dart';

import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../global/streamsObjects.dart';
import '../../../models/chapter_exercise_model/chapter_ex_get_model.dart';
import '../../../view_model/addcomment_bloc/adcomment_bloc.dart';
import '../../../view_model/chapter_exercise_bloc/chapter_exercise_bloc.dart';
import '../../../view_model/chapter_exercise_bloc/chapter_exercise_event.dart';
import '../../../view_model/chapter_exercise_bloc/chapter_exercise_states.dart';
import '../../../view_model/comment_list_bloc/comment_list_bloc.dart';
import '../../../view_model/comment_list_bloc/comment_list_event.dart';
import '../../../view_model/comment_list_bloc/comment_list_state.dart';
import '../../../view_model/delete_comment_bloc/delete_comment_bloc.dart';
import '../../../view_model/delete_comment_bloc/delete_comment_event.dart';
import '../../../view_model/delete_comment_bloc/delete_comment_state.dart';
import '../../../view_model/edit_comment_bloc/edit_comment_bloc.dart';
import '../../../view_model/edit_comment_bloc/edit_comment_event.dart';
import '../../../view_model/edit_comment_bloc/edit_comment_state.dart';
import '../../../view_model/like_bloc/like_bloc.dart';
import '../../../view_model/like_bloc/like_event.dart';
import '../../../view_model/like_bloc/like_state.dart';
import '../choose_subscription/choose_subscription.dart';

class ChapterExerciseScreen extends StatefulWidget {
  final String? getImage;
  final String? getExerciseId;

  const ChapterExerciseScreen({
    Key? key,
    this.getImage,
    this.getExerciseId,
  }) : super(key: key);

  @override
  State<ChapterExerciseScreen> createState() => _ChapterExerciseScreenState();
}

class _ChapterExerciseScreenState extends State<ChapterExerciseScreen> {
  ChapterExerciseBloc chapterExerciseBloc =
      ChapterExerciseBloc(ChapterExInitialState());
  LikeDislikeBloc likeDislikeBloc = LikeDislikeBloc(LikeInitialState());
  AddCommentBloc addCommentBloc = AddCommentBloc(AddCommentInitialState());
  TextEditingController commentController = TextEditingController();
  CommentListBloc commentListBloc = CommentListBloc(CommentListInitialState());
  DeleteCommentBloc deleteCommentBloc =
      DeleteCommentBloc(DelCommentInitialState());
  EditCommentBloc editCommentBloc = EditCommentBloc(EditCommentInitialState());
  bool isHide = true;
  int selected = 0;
  bool isKey = false;

  // StreamController<int> streamController = StreamController<int>.broadcast();
  bool is_edit = false;
  EditCommentEvent? edit_event;
  @override
  void initState() {
    chapterExerciseBloc.add(ChapterExEvent(id: widget.getExerciseId));
    super.initState();
  }

  @override
  void dispose() {
    commentController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: isHide
            ? myCustomAppBar(
                backButton: BackButton(
                  color: AppColors.allButtonColor,
                ),
                titleAppBar: 'Chapter Exercise'.tr,
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
                    height: height * 0.020,
                  ),
                  BlocBuilder<ChapterExerciseBloc, ChapterExerciseState>(
                    bloc: chapterExerciseBloc,
                    builder: (context, state) {
                      if (state is ChapterExLoadedState) {
                        return Container(
                          margin: EdgeInsets.only(left: width * 0.01),
                          // height: height * 0.11,
                          width: width * 0.94,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.buttoncolore
                                        .withOpacity(0.14),
                                    offset: Offset(4, 6),
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ],
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.020,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: height * 0.01),
                                    //height: height * 0.080,
                                    width: width * 0.13,
                                    child: Image.network(
                                      '$baseImageUrl' + '${widget.getImage}',
                                    ),
                                  ),
                                  SizedBox(width: width * 0.020),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${state.response.data![0].bookName}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: width * 0.039,
                                                    color: AppColors
                                                        .allButtonColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.010,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width * 0.05),
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
                                                            //cacheHeight: 18,
                                                            height:
                                                                height * 0.025,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? AppColors
                                                                    .blackColor
                                                                : AppColors
                                                                    .textColor,
                                                          )
                                                        : Icon(
                                                            Icons.zoom_out_map,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? AppColors
                                                                    .blackColor
                                                                : AppColors
                                                                    .textColor,
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Chapter'.tr + '${state.response.data![0].chapId}',
                                              style: TextStyle(
                                                  //  color: Colors.black.withOpacity(0.75),
                                                  fontSize: width * 0.04),
                                            ),
                                            SizedBox(
                                              width: width * 0.010,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width * 0.030),
                                              child: Text(
                                                'Exercise'.tr + '${state.response.data![0].execNum}',
                                                style: TextStyle(
                                                    // color: Colors.black.withOpacity(0.60),
                                                    fontSize: width * 0.04),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.005,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'step by step solution'.tr,
                                              style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  color: AppColors.lightblack2),
                                            ),
                                            SizedBox(
                                              width: width * 0.020,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: height * 0.015,
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: Text(' '),
                        );
                      }
                    },
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15),
                      height: height * 0.12,
                      width: width * 0.90,
                      // color: Colors.red,
                      child: BlocConsumer<ChapterExerciseBloc,
                          ChapterExerciseState>(
                        bloc: chapterExerciseBloc,
                        builder: (context, state) {
                          if (state is ChapterExLoadedState) {
                            return ChapterUi(context, state.response);
                          } else if (state is ChapterExLoadingState) {
                            return Container(
                              height: height,
                              width: width,
                              child: Center(
                                  child: SpinKitFadingCircle(
                                size: 50,
                                color: AppColors.circlepicker,
                              )),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : AppColors.blackColor),
                            );
                          } else {
                            return Container(
                              child: Text(''),
                            );
                          }
                        },
                        listener: (context, state) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ChapterUi(BuildContext context, ChapterExGetModel chapterExGetModel) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ListView.builder(
        itemCount: chapterExGetModel.data!.length,
        itemBuilder: (context, uper_index) {
          return Column(
            children: [
              ExpansionTile(
                initiallyExpanded:true,
                trailing: Image.asset(
                  'assets/dropdown.png',
                  cacheHeight: 15,
                ),
                iconColor: Colors.transparent,
                title: Container(
                  height: height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Question 1'.tr,
                          style: TextStyle(
                              color: AppColors.allButtonColor,
                              fontSize: width * 0.043),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text(
                          '${chapterExGetModel.data![uper_index].questInfo}',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: width * 0.045),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.025,
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/bookmark.png',
                          height: height * 0.05,
                        ),
                      )
                    ],
                  ),
                ),
                children: [
                  ...chapterExGetModel.data![uper_index].solution!.map((e) {
                    int index=chapterExGetModel.data![uper_index].solution!.indexOf(e);
                    return InkWell(
                      onTap: (){
                        print('click');
                            if(storage.hasData('token')){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actions: [
                                        Container(
                                          // height: height * 0.43,
                                          width: width * 0.85,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Image.asset(
                                                        'assets/cross.png',
                                                        fit: BoxFit.cover,
                                                      ))
                                                ],
                                              ),
                                              // SizedBox(
                                              //   height: height*0.010,
                                              // ),
                                              Container(
                                                  height: height * 0.22,
                                                  width: width * 0.32,
                                                  child: Image.asset(
                                                    'assets/subscribed_img.png',
                                                  )),
                                              Text(
                                                'Please subscribe to your'.tr +'\n'+'favorable package for'.tr+'\n'+'complete solution'.tr,
                                                style: TextStyle(
                                                    fontSize: width * 0.05,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    color:
                                                    AppColors.blackColor),
                                              ),
                                              SizedBox(
                                                  height: height * 0.025),
                                              MyCustomButton(
                                                text: 'SUBSCRIBE NOW'.tr,
                                                height: height * 0.05,
                                                width: width * 0.9,
                                                buttonColors:
                                                AppColors.allButtonColor,
                                                myimag: Image.asset(
                                                  'assets/book.png',
                                                  color: Colors.white,
                                                ),
                                                ontap: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChooseSubscriptionScreen(),
                                                      ));
                                                },
                                              ),
                                              SizedBox(
                                                height: height * 0.012,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  });
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
                      child: IgnorePointer(
                        ignoring: index>=2? true:false,
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).brightness == Brightness.light
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                              border: Border.all(
                                  color: AppColors.blackColor, width: 0.8),
                              borderRadius: BorderRadius.circular(7)),
                          margin: EdgeInsets.only(
                              top: height * 0.016,
                              left: width * 0.07,
                              right: width * 0.07),
                          child: ExpansionTile(
                            collapsedIconColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                            iconColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                            tilePadding: EdgeInsets.only(
                                left: width * 0.04, right: width * 0.04),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Step'.tr +'${e.solId}',
                                  style: TextStyle(
                                      //color: AppColors.lightblack,
                                      fontSize: width * 0.045),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.zero,
                                              content: StatefulBuilder(
                                                  builder: ((context, setState) {
                                                return Container(
                                                  height: height * 0.8,
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: width * 0.22,
                                                            top: height * 0.015),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Comments'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width * 0.05,
                                                                  color: AppColors
                                                                      .allButtonColor),
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    width * 0.18),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Container(
                                                                    child: Image.asset(
                                                                        'assets/cross.png')))
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: BlocBuilder<
                                                            CommentListBloc,
                                                            CommentListState>(
                                                          bloc: commentListBloc,
                                                          builder:
                                                              (context, state) {
                                                            print(
                                                                'Data Loaded is =====${commentListBloc}');
                                                            if (state
                                                                is CommentListLoadedState) {
                                                              return Container(
                                                                child: ListView
                                                                    .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: state
                                                                            .response
                                                                            .data!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                lower_index) {
                                                                          if (state
                                                                                  .response !=
                                                                              null) {
                                                                            return Column(
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: height * 0.020,
                                                                                ),
                                                                                Container(
                                                                                  width: width * 0.69,
                                                                                  decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.black), borderRadius: BorderRadius.circular(6)),
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        height: height * 0.020,
                                                                                      ),
                                                                                      Row(
                                                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: width * 0.040,
                                                                                          ),
                                                                                          Expanded(
                                                                                            flex: 5,
                                                                                            child: Text(
                                                                                              '${state.response.data![lower_index].fname}',
                                                                                              style: TextStyle(color: AppColors.allButtonColor, fontSize: width * 0.04),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            flex: 5,
                                                                                            child: Row(
                                                                                              //  mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                SizedBox(
                                                                                                  width: width * 0.19,
                                                                                                ),
                                                                                                GestureDetector(
                                                                                                  onTap: () {
                                                                                                    is_edit = true;
                                                                                                    commentController.text = '${state.response.data![lower_index].comment}';
                                                                                                    edit_event = EditCommentEvent(solId: state.response.data![lower_index].solId, chpId: state.response.data![lower_index].cid, comment: commentController.text);
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: height * 0.030,
                                                                                                    width: width * 0.060,
                                                                                                    child: Image.asset('assets/edit_orange.png'),
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: width * 0.03,
                                                                                          ),
                                                                                          GestureDetector(
                                                                                            onTap: () async {
                                                                                              deleteCommentBloc.add(DeleteCommentEvent(cId: state.response.data![lower_index].cid));
                                                                                              Future.delayed(Duration(seconds: 1), () {
                                                                                                commentListBloc.add(CommentListEvent(exId: chapterExGetModel.data![uper_index].execId, solId: chapterExGetModel.data![uper_index].solution![uper_index].solId));
                                                                                              });
                                                                                            },
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.only(right: 8.0, left: 8),
                                                                                              child: Container(
                                                                                                height: height * 0.030,
                                                                                                width: width * 0.060,
                                                                                                child: Image.asset('assets/delete.png'),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: height * 0.010,
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
                                                                                        child: Text(
                                                                                          '${state.response.data![lower_index].comment}',
                                                                                          style: TextStyle(fontSize: width * 0.04),
                                                                                          textAlign: TextAlign.start,
                                                                                          softWrap: true,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: width * 0.040,
                                                                                        height: height * 0.01,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            );
                                                                          } else {
                                                                            return Center(
                                                                              child:
                                                                                  Container(
                                                                                height:
                                                                                    height,
                                                                                width:
                                                                                    width,
                                                                                child: Center(
                                                                                    child: SpinKitFadingCircle(
                                                                                  size: 50,
                                                                                  color: AppColors.circlepicker,
                                                                                )),
                                                                                decoration:
                                                                                    BoxDecoration(color: Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.blackColor),
                                                                              ),
                                                                            );
                                                                          }
                                                                        }),
                                                              );
                                                            } else if (state
                                                                is CommentListErrorState) {
                                                              return Text(' ');
                                                            } else {
                                                              return Container(
                                                                height: height,
                                                                width: width,
                                                                child: Center(
                                                                    child:
                                                                        SpinKitFadingCircle(
                                                                  size: 50,
                                                                  color: AppColors
                                                                      .circlepicker,
                                                                )),
                                                                decoration: BoxDecoration(
                                                                    color: Theme.of(context)
                                                                                .brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? Colors
                                                                            .white
                                                                        : AppColors
                                                                            .blackColor),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8)),
                                                                    height: height *
                                                                        0.05,
                                                                    // width: width * 0.62,
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          commentController,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              width *
                                                                                  0.04),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor: Theme.of(context).brightness ==
                                                                                Brightness
                                                                                    .light
                                                                            ? AppColors
                                                                                .textColor
                                                                            : AppColors
                                                                                .fillColor,
                                                                        // AppColors.textfieldcoment,
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8)),
                                                                        filled:
                                                                            true,
                                                                        hintText:
                                                                            'Write a Comment'
                                                                                .tr,
                                                                        hintStyle: TextStyle(
                                                                            fontSize:
                                                                                width *
                                                                                    0.04,
                                                                            color: Theme.of(context).brightness ==
                                                                                    Brightness.light
                                                                                ? Colors.black38
                                                                                : AppColors.textColor),
                                                                        focusedBorder:
                                                                            InputBorder
                                                                                .none,
                                                                        enabledBorder:
                                                                            InputBorder
                                                                                .none,
                                                                        labelStyle:
                                                                            TextStyle(
                                                                                color:
                                                                                    AppColors.blackColor),
                                                                      ),
                                                                    )),
                                                              ),
                                                              SizedBox(
                                                                  width: width *
                                                                      0.010),
                                                              Container(
                                                                height:
                                                                    height * 0.04,
                                                                child:
                                                                    GestureDetector(
                                                                        onTap: () {
                                                                          if (!is_edit) {
                                                                            addCommentBloc.add(AddCommentEvent(
                                                                                comment:
                                                                                    commentController.text,
                                                                                chpId: chapterExGetModel.data![uper_index].chapId,
                                                                                bId: chapterExGetModel.data![uper_index].bookId,
                                                                                exId: chapterExGetModel.data![uper_index].execId,
                                                                                solId: chapterExGetModel.data![uper_index].solution![uper_index].solId));
                                                                            commentController
                                                                                .clear();
                                                                            Future.delayed(
                                                                                Duration(seconds: 1),
                                                                                () {
                                                                              commentListBloc.add(CommentListEvent(
                                                                                  exId: chapterExGetModel.data![uper_index].execId,
                                                                                  solId: chapterExGetModel.data![uper_index].solution![uper_index].solId));
                                                                            });
                                                                          } else {
                                                                            edit_event!.comment =
                                                                                commentController.text;
                                                                            editCommentBloc
                                                                                .add(edit_event!);
                                                                            is_edit =
                                                                                false;
                                                                            commentController
                                                                                .clear();
                                                                            Future.delayed(
                                                                                Duration(seconds: 1),
                                                                                () {
                                                                              commentListBloc.add(CommentListEvent(
                                                                                  exId: chapterExGetModel.data![uper_index].execId,
                                                                                  solId: chapterExGetModel.data![uper_index].solution![uper_index].solId));
                                                                            });
                                                                          }
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/send.png',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })),
                                            );
                                          });
                                      commentListBloc.add(CommentListEvent(
                                          exId: chapterExGetModel
                                              .data![uper_index].execId,
                                          solId: chapterExGetModel.data![uper_index]
                                              .solution![uper_index].solId));
                                    },
                                    child: Image.asset(
                                      'assets/comment_green.png',
                                      fit: BoxFit.cover,
                                    ))
                              ],
                            ),
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.035,
                                  ),
                                  Text(
                                    'Tittle:'.tr +'${e.solNum}',
                                    style: TextStyle(fontSize: width * 0.042),
                                    maxLines: 1,
                                  ),
                                  SizedBox(
                                    width: width * 0.020,
                                  ),
                                  Expanded(
                                      child: Text('${e.solTxt}',
                                          style: TextStyle(fontSize: width * 0.04),
                                          maxLines: 1))
                                ],
                              ),
                              SizedBox(height: height * 0.010),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  SizedBox(),
                  SizedBox(
                    height: height * 0.060,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Was this Solution Helpful?'.tr,
                          style: TextStyle(
                              fontSize: width * 0.04,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  likeDislikeBloc.add(LikeEvent(
                                      exId: chapterExGetModel
                                          .data![uper_index].execId,
                                      bId: chapterExGetModel
                                          .data![uper_index].bookId,
                                      chpId: chapterExGetModel
                                          .data![uper_index].chapId,
                                      solId: chapterExGetModel.data![uper_index]
                                          .solution![uper_index].solId,
                                      likeDislike: chapterExGetModel
                                          .data![uper_index]
                                          .solution![uper_index]
                                          .commentcount));
                                },
                                child: Image.asset('assets/like.png'),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset('assets/unlike.png'),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        });
  }
}
