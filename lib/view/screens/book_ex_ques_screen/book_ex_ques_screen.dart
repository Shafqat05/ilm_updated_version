//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:ilm_updated_version/view_model/book_ex_ques_bloc/book_ex_ques_event.dart';
import 'package:get/get.dart';
import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../models/book_ex_question_get_model/book_ex_question_get_model.dart';
import '../../../view_model/book_ex_ques_bloc/book_ex_ques_bloc.dart';
import '../../../view_model/book_ex_ques_bloc/book_ex_question_state.dart';

class BookExQuestionScreen extends StatefulWidget {
  final String? getImage;
  final String? chpId;
  final String? exId;
  const BookExQuestionScreen({Key? key, this.getImage, this.chpId,this.exId}) : super(key: key);

  @override
  State<BookExQuestionScreen> createState() => _BookExQuestionScreenState();
}

class _BookExQuestionScreenState extends State<BookExQuestionScreen> {

  BookExQuestionBloc bookExQuestionBloc = BookExQuestionBloc(BookExQuesInitialState());
  BookExQuesLoadedState? bookExQuesLoadedState;

  @override
  void initState() {
    bookExQuestionBloc.add(BookExQuestionEvent(id: widget.chpId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: myCustomAppBar(
          backButton: BackButton(
            color: AppColors.allButtonColor,
          ),
          titleAppBar: 'Booking Detail'.tr,
          context: context
        ),

        body: Stack(
          children: [

                  Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.020,
                    ),
                    BlocBuilder<BookExQuestionBloc, BookExQuestionState>(
                        bloc: bookExQuestionBloc,
                        builder: (context, state) {
                          if(state is BookExQuesLoadedState){
                            return Container(
                              // margin: EdgeInsets.only(left: width * 0.01),
                              height: height * 0.11,
                              width: width * 0.93,
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
                                  color: AppColors.whiteColor),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.020,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 12),
                                        height: height * 0.090,
                                        width: width * 0.15,
                                        child: Image.network(
                                          // '$baseImageUrl' +
                                          '${widget.getImage}',
                                        ),
                                      ),
                                      SizedBox(width: width * 0.020),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child:  Text(
                                                        '${state.response.data![0].questInfo}',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: AppColors.allButtonColor,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            'assets/fullscreen.png',
                                                            cacheHeight: 22,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Chapter ${widget.chpId}'.tr,
                                                      style: TextStyle(
                                                          color: Colors.black.withOpacity(0.60),

                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.010,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: width * 0.030),
                                                      child: Text(
                                                        'Exercise ${widget.exId}'.tr,
                                                        style: TextStyle(
                                                            color: Colors.black.withOpacity(0.60),
                                                            fontSize: 13),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'step by step solution'.tr,
                                                      style: TextStyle(
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
                                ],
                              ),
                            );
                          }

                          else{
                            return Container(child: Text(''),);
                          }
                        },),
                    SizedBox(
                      height: height * 0.020,
                    ),
                    Expanded(
                      child: BlocConsumer<BookExQuestionBloc, BookExQuestionState>(
                        bloc: bookExQuestionBloc,
                        builder: (context, state) {
                          if(state is BookExQuesLoadedState){
                            return BookExQuesUi(context, state.response);
                          }
                          else if(state is BookExQuesLoadingState){
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
                              BoxDecoration(color: Colors.white),
                            );
                          }
                          else{
                            return Container(child: Text(''),);
                          }
                        },
                        listener: (context, state) {

                        },
                      ),
                    ),
                  ],
                ),
              ),
          //  ),
          ],
        ),
      ),
    );
  }

  Widget BookExQuesUi(BuildContext context, BookExQuesGetModel bookExQuesGetModel){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Container(
            margin: EdgeInsets.all(12),
            height: height * 0.50,
            decoration: BoxDecoration(

                border: Border.all(
                  color: AppColors.buttoncolore.withOpacity(0.60),

                  width: 0.09,),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      Text(
                        'Question 2 '.tr,
                        style: TextStyle(
                            color: AppColors.allButtonColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${bookExQuesGetModel.data![0].questInfo}',
                        style: TextStyle(color: Colors.black.withOpacity(0.40)),
                      ),

                      Row(
                        children: [
                          SizedBox(
                            width: width*0.060,
                          ),
                          //     Image.asset(
                          // 'assets/bookmark_green.png'),
                          Icon(Icons.bookmark,color: Colors.black.withOpacity(0.18),)
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(
                            width: width*0.060,
                          ),
                          Image.asset('assets/dropdown.png',cacheHeight: 25,),
                        ],
                      ),


                    ],
                  ),

                ),
                SizedBox(
                  height: height * 0.040,
                ),
                Container(
                  height: 210,
                  width: 350,
                  child: Image.network(
                    '$baseImageUrl' +
                        '${bookExQuesGetModel.data![0].questImage}',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                Text(
                  'Sorry Solution not found'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  softWrap: true,
                )
              ],
            ))
      ],
    );
  }

}
