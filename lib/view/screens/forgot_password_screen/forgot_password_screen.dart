import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../view_model/forgot_password_bloc/forgot_password_bloc.dart';
import '../../../view_model/forgot_password_bloc/forgot_password_event.dart';
import '../../../view_model/forgot_password_bloc/forgot_password_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordBloc forgotPasswordBloc = ForgotPasswordBloc(ForgotPassInitialState());
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var height = size.maxHeight;
      var width = size.maxWidth;
      return Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: height,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.20,
                    ),
                    Center(
                      child: Container(
                        height: height * 0.30,
                        width: width * 0.50,

                        child: Image.asset('assets/reset_password_img.png'),
                      ),
                    ),

                    Text(
                      'Forgot your Password ?'.tr,
                      style: TextStyle(
                          fontSize: width * 0.05,
                          color: AppColors.allButtonColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text(
                      'please enter your email address'.tr+'\n'+ 'to get a link or enter phone'.tr+'\n'+ 'Number to get a verification code'.tr,
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.textColor,fontSize: width * 0.04),
                    ),
                    SizedBox(
                      height: height*0.030,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: width * 0.03,right: width * 0.03),
                          child: CustomTextField(
                            width: width*0.93,
                            mylabeltext: 'Email'.tr,
                            textInputAction: TextInputAction.done,
                            controller: emailController,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height*0.030,
                    ),
                    GestureDetector(
                      onTap: (){
                        if (emailController.text.isEmpty) {
                          showToast(
                              'Please Enter email'.tr,
                              context: context,
                              animation: StyledToastAnimation.fade,
                              curve: Curves.linear,
                              reverseCurve: Curves.linear);
                        } else{

                          forgotPasswordBloc.add(ForgotPasswordEvent(email: emailController.text));

                        }
                      },
                      child: Container(
                          height: height * 0.060,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: AppColors.allButtonColor,
                              boxShadow: [BoxShadow()],
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                              bloc: forgotPasswordBloc,
                              builder: (context, state) {
                                if(state is ForgotPassLoadingState){
                                  return Center(
                                      child: SpinKitFadingCircle(
                                        size: 50,
                                        color: AppColors.circlepicker,
                                      )
                                  );
                                }
                                else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.055,
                                      ),
                                      Text(
                                        'SEND'.tr,
                                        style: TextStyle(color: AppColors.whiteColor, fontSize: width * 0.055),
                                      ),
                                      //Icon(iconA,size: 28,color: AppColors.whiteColor,),
                                      Container(
                                        height: height * 0.39,
                                        child: Image.asset(
                                          'assets/book.png',
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  );
                                }

                              },
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
