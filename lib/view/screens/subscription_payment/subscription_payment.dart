import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../view_model/do_subscription_bloc/do_subscription_bloc.dart';
import '../../../view_model/do_subscription_bloc/do_subscription_state.dart';

class SubscriptionPaymentScreen extends StatefulWidget {
  final String? getMonthId;
  final String? getPrice;
  const SubscriptionPaymentScreen({Key? key, this.getMonthId,this.getPrice}) : super(key: key);

  @override
  State<SubscriptionPaymentScreen> createState() => _SubscriptionPaymentScreenState();
}

class _SubscriptionPaymentScreenState extends State<SubscriptionPaymentScreen> {
  DoSubscriptionBloc doSubscriptionBloc = DoSubscriptionBloc(DoSubsInitialState());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, size) {
        var height = size.maxHeight;
        var width = size.maxWidth;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: myCustomAppBar(
            titleAppBar: 'Subscription Method'.tr,
            fontSize: width * 0.04,
            context: context,
            backButton: BackButton(
              color: AppColors.allButtonColor,
            ),
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            // height: height * 0.20,
                            width: width * 0.92,
                            //color: Colors.red,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: AppColors.allButtonColor, width: 0.06)),
                            child: Padding(
                              padding:  EdgeInsets.only(top: width*0.050),
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.08,
                                    width: width * 0.15,
                                    child: Image.asset('assets/renew_img.png'),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  Text(
                                    '${widget.getMonthId}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: width * 0.045,
                                        color: Theme.of(context).brightness == Brightness.light ? AppColors.textColor : AppColors.textColor),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  Text(
                                    'AED'.tr+"${widget.getPrice}/-",
                                    style: TextStyle(
                                        fontSize: width * 0.05,
                                        color: AppColors.allButtonColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: height * 0.012,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Container(
                            // height: height * 0.26,
                              width: width * 0.92,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 0.05, color: AppColors.buttoncolore),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.030,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 40),
                                    child: TextFormField(
                                      cursorColor: AppColors.buttoncolore,
                                      style: TextStyle(
                                          fontSize: width * 0.04,
                                          color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor

                                      ),
                                      decoration: InputDecoration(
                                        //border: InputBorder.none,
                                        labelStyle: TextStyle(color: Colors.red,fontSize: width * 0.04),
                                        hintText: 'Card Holder Name'.tr,
                                        hintStyle: TextStyle(
                                            fontSize: width * 0.033,
                                            color: Theme.of(context).brightness == Brightness.light ? AppColors.textColor : AppColors.textColor),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        fillColor: Theme.of(context).brightness == Brightness.light ? AppColors.textfieldcolor : AppColors.blackColor,
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 40),
                                    child: TextFormField(
                                      cursorColor: AppColors.buttoncolore,
                                      style: TextStyle(
                                          fontSize: width * 0.04,
                                          color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor
                                      ),
                                      decoration: InputDecoration(
                                        //border: InputBorder.none,
                                        labelStyle: TextStyle(color: Colors.red),

                                        hintText: 'Card Number'.tr,
                                        hintStyle: TextStyle(
                                            fontSize: width * 0.033,
                                            color: Theme.of(context).brightness == Brightness.light ? AppColors.textColor : AppColors.textColor),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        fillColor: Theme.of(context).brightness == Brightness.light ? AppColors.textfieldcolor : AppColors.blackColor,
                                        filled: true,

                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.10,
                                      ),
                                      Text(
                                        'VALID THRU'.tr,
                                        style: TextStyle(
                                            fontSize: width * 0.03, color: AppColors.validthru),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.090,
                                      ),
                                      Container(
                                        height: height * 0.04,
                                        width: width * 0.20,
                                        //margin:EdgeInsets.only(left: 40,right: 40),
                                        child: TextFormField(
                                          cursorColor: AppColors.buttoncolore,
                                          style: TextStyle(
                                              fontSize: width * 0.04,
                                              color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor
                                          ),
                                          decoration: InputDecoration(
                                            //border: InputBorder.none,
                                            labelStyle: TextStyle(color: Colors.red),
                                            hintText: 'YY'.tr,
                                            hintStyle: TextStyle(
                                                fontSize: width * 0.04,
                                                color: Theme.of(context).brightness == Brightness.light ? AppColors.textColor : AppColors.textColor),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            fillColor: Theme.of(context).brightness == Brightness.light ? AppColors.textfieldcolor : AppColors.blackColor,
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.020,
                                      ),
                                      Text('/',style: TextStyle(fontSize: width * 0.038),),
                                      SizedBox(width: width * 0.020),
                                      Container(
                                        height: height * 0.04,
                                        width: width * 0.20,
                                        //margin:EdgeInsets.only(left: 40,right: 40),
                                        child: TextFormField(
                                          cursorColor: AppColors.buttoncolore,
                                          style: TextStyle(
                                              fontSize: width * 0.04,
                                              color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor
                                          ),
                                          decoration: InputDecoration(
                                            //border: InputBorder.none,
                                            labelStyle: TextStyle(color: Colors.red),
                                            hintText: 'MM'.tr,
                                            hintStyle: TextStyle(
                                                fontSize: width * 0.04,
                                                color: Theme.of(context).brightness == Brightness.light ? AppColors.textColor : AppColors.textColor),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            fillColor: Theme.of(context).brightness == Brightness.light ? AppColors.textfieldcolor : AppColors.blackColor,
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.020,
                                      ),
                                      Container(
                                        height: height * 0.04,
                                        width: width * 0.20,
                                        //margin:EdgeInsets.only(left: 40,right: 40),
                                        child: TextFormField(
                                          cursorColor: AppColors.buttoncolore,
                                          style: TextStyle(
                                              fontSize: width * 0.04,
                                              color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor
                                          ),
                                          decoration: InputDecoration(
                                            //border: InputBorder.none,
                                            labelStyle: TextStyle(color: Colors.red),
                                            hintText: 'CVV'.tr,
                                            hintStyle: TextStyle(
                                                fontSize: width * 0.04,
                                                color: Theme.of(context).brightness == Brightness.light ? AppColors.textColor : AppColors.textColor),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            fillColor: Theme.of(context).brightness == Brightness.light ? AppColors.textfieldcolor : AppColors.blackColor,
                                            filled: true,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.012,
                                  )
                                ],
                              )),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                                height: height * 0.045,
                                width: width * 0.83,
                                decoration: BoxDecoration(
                                    color: AppColors.allButtonColor,
                                    boxShadow: [BoxShadow()],
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15, left: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.055,
                                      ),
                                      Text(
                                        'PAY NOW'.tr,
                                        style: TextStyle(color: AppColors.whiteColor, fontSize: width * 0.055),
                                      ),
                                      //Icon(iconA,size: 28,color: AppColors.whiteColor,),
                                      Container(
                                        height: height * 0.39,
                                        child:Image.asset('assets/book.png',color: Colors.white,),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          // MyCustomButton(
                          //   height: height * 0.04,
                          //   width: width * 0.83,
                          //   text: 'Play Now',
                          //   buttonColors: AppColors.allButtonColor,
                          //   myimag: Image.asset('assets/book.png',color: Colors.white,),
                          // ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Text(
                            'OR'.tr,
                            style: TextStyle(color: AppColors.allButtonColor,fontSize: width * 0.036),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: height * 0.057,
                              width: width * 0.90,
                              color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor : AppColors.blackColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: height * 0.090,
                                    width: width * 0.12,
                                    child: Image.asset('assets/google.png'),
                                  ),
                                  Text(
                                    'Pay'.tr,
                                    style: TextStyle(fontSize: width * 0.05,),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020,
                          ),
                          Text('We ACCEPT'.tr,
                              style: TextStyle(fontSize: width * 0.045, )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: height * 0.08,
                                width: width * 0.12,
                                child: Image.asset('assets/master_card.png'),
                              ),
                              SizedBox(
                                width: width * 0.040,
                              ),
                              Container(
                                height: height * 0.08,
                                width: width * 0.12,
                                child: Image.asset('assets/visa_card.png'),
                              ),
                              SizedBox(
                                width: width * 0.020,
                              ),
                              Container(
                                height: height * 0.08,
                                width: width * 0.12,
                                child: Image.asset('assets/google_pay.png'),
                              ),
                              SizedBox(
                                width: width * 0.020,
                              ),
                              Container(
                                height: height * 0.08,
                                width: width * 0.12,
                                child: Image.asset(
                                  'assets/apple_pay.png',
                                color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*0.02,
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
