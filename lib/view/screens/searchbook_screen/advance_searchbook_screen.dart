import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';

class AdvanceSearchBookScreen extends StatefulWidget {
  const AdvanceSearchBookScreen({Key? key}) : super(key: key);

  @override
  State<AdvanceSearchBookScreen> createState() => _AdvanceSearchBookScreenState();
}

class _AdvanceSearchBookScreenState extends State<AdvanceSearchBookScreen> {

  TextEditingController bNameController = TextEditingController();
  TextEditingController bAuthorController = TextEditingController();
  TextEditingController isbnController = TextEditingController();

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'.tr),
        content: Text('Do you want to exit an App?'.tr),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'.tr),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            child:Text('Yes'.tr),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
        child: LayoutBuilder(builder: (context, size) {
          var height = size.maxHeight;
          var width = size.maxWidth;
          return Scaffold(
            appBar: myCustomAppBar(
              backButton: BackButton(
                color: Colors.transparent,
              ),
              titleAppBar: 'Advance Search'.tr,
              context: context,
              fontSize: width * 0.04
            ),


            body: Stack(
              children: [
                ListView(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Center(
                            child: Container(
                              height: height * 0.20,
                              width: width * 0.32,
                              child: Image.asset('assets/advance_search_img.png'),
                            ),
                          ),
                          SizedBox(
                            height: height*0.020,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * 0.040,top: width*0.010,right: width * 0.040),
                            child: Row(
                              children: [
                                Text(
                                  'Please Enter Detail'.tr,
                                  style: TextStyle(
                                      fontSize: width * 0.048, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.040,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left:width * 0.03,right: width * 0.03),
                                child: Row(
                                    children:[
                                      Text(
                                        'Book Title'.tr,
                                        style: TextStyle(color: AppColors.lightblack2,fontSize: width * 0.04),),
                                    ]
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: width * 0.93,
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColors.buttoncolore,
                              controller: bNameController,
                              style: TextStyle(fontSize: width * 0.04),
                              //cursorHeight: 0.5,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.buttoncolore, width: 2.0),
                                  ),

                                  hintText: 'Search by Book Title'.tr,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.textColor,
                                      fontSize: width * 0.04)),
                            ),
                          ),
                          SizedBox(
                            height: height*0.015,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left:width * 0.03,right: width * 0.03),
                                child: Row(
                                    children:[
                                      Text('Author Name'.tr,style: TextStyle(color: AppColors.lightblack2,fontSize: width * 0.04),),
                                    ]
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: width * 0.93,
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColors.buttoncolore,
                              controller: bAuthorController,
                              style: TextStyle(fontSize: width * 0.04),
                              //cursorHeight: 0.5,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.buttoncolore, width: 2.0),
                                  ),

                                  hintText: 'Search by Author Name'.tr,
                                  hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.textColor,fontSize: width * 0.04)),
                            ),
                          ),
                          SizedBox(
                            height: height*0.015,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left:width * 0.03,right: width * 0.03),
                                child: Row(
                                    children:[
                                      Text('ISBN:'.tr,style: TextStyle(color: AppColors.lightblack2,fontSize: width * 0.04),),
                                    ]
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: width * 0.93,
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              cursorColor: AppColors.buttoncolore,
                              controller: isbnController,
                              style: TextStyle(fontSize: width * 0.04),
                              //cursorHeight: 0.5,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.buttoncolore, width: 2.0),
                                  ),

                                  hintText: 'Search by ISBN'.tr,
                                  hintStyle: TextStyle(color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.textColor,fontSize: width * 0.04)),
                            ),
                          ),

                          SizedBox(
                            height: height * 0.030,
                          ),
                          MyCustomButton(
                            height: height * 0.066,
                            width: width * 0.9,
                            text: 'SEARCH'.tr,
                            buttonColors: AppColors.allButtonColor,
                            myimag: Image.asset('assets/book.png',color: Colors.white,),
                            ontap: (){
                              if(bNameController.text.isEmpty){
                                showToast(
                                  'Please Enter Book Name'.tr,
                                  context: context,
                                  animation: StyledToastAnimation.fade,
                                  curve: Curves.linear,
                                  reverseCurve: Curves.linear,
                                );
                              }
                              else if(bAuthorController.text.isEmpty){
                                showToast(
                                    'Please Enter Book Author Name'.tr,
                                    context: context,
                                    animation: StyledToastAnimation.fade,
                                    curve: Curves.linear,
                                    reverseCurve: Curves.linear);
                              }
                              else if(isbnController.text.isEmpty){
                                showToast(
                                    'Please Enter Isbn'.tr,
                                    context: context,
                                    animation: StyledToastAnimation.fade,
                                    curve: Curves.linear,
                                    reverseCurve: Curves.linear);
                              }
                            },
                          ),
                          SizedBox(
                            height: height * 0.03,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
