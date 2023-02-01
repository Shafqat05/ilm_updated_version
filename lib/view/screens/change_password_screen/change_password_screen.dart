//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../view_model/change_password_bloc/change_password_bloc.dart';
import '../../../view_model/change_password_bloc/change_password_event.dart';
import '../../../view_model/change_password_bloc/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordBloc changePasswordBloc = ChangePasswordBloc(ChangePassInitialState());
  TextEditingController oldPassController = TextEditingController();
  TextEditingController conformPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var height = size.maxHeight;
      var width = size.maxWidth;
      return SafeArea(
        child: Scaffold(
          appBar: myCustomAppBar(
              backButton: BackButton(
                color: AppColors.allButtonColor,
              ),
              fontSize: width * 0.04,
              context: context,
              titleAppBar: 'Reset Password'.tr),
          body: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.020,
                    ),
                    Container(
                        height: height * 0.13,
                        width: width * 0.26,
                        child: Image.asset('assets/reset_password_img.png'),
                        // CircleAvatar(
                        //   backgroundColor: AppColors.profilecolor,
                        //   child: Center(
                        //     child: Icon(
                        //       Icons.person,
                        //       size: width*0.2,
                        //       color: AppColors.whiteColor,
                        //     ),
                        //   ),
                        // )
                    ),
                    SizedBox(
                      height: height * 0.050,
                    ),
                    Text(
                      'Reset Password'.tr,
                      style: TextStyle(
                          color: AppColors.allButtonColor,
                          fontSize: width * 0.053,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.020,
                    ),
                    Text(
                      'Please enter and conform your'.tr,
                      style:
                      TextStyle(fontSize: width * 0.047, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'new password'.tr,
                      style:
                      TextStyle(fontSize: width * 0.047, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: height * 0.028,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.04, right: width * 0.025),
                      child: CustomTextField(
                        width: width * 0.90,
                        mylabeltext: 'Old Password'.tr,
                        textInputAction: TextInputAction.next,
                        controller: oldPassController,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.020,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.04, right: width * 0.025),
                      child: CustomTextField(
                        width: width * 0.90,
                        mylabeltext: 'Conform New Password'.tr,
                        textInputAction: TextInputAction.next,
                        controller: conformPassController,
                      ),
                    ),
                    SizedBox(),
                    SizedBox(
                      height: height * 0.0280,
                    ),
                    GestureDetector(
                      onTap: (){
                        if (oldPassController.text.isEmpty) {
                          showToast(
                              'Please Enter old password'.tr,
                              context: context,
                              animation: StyledToastAnimation.fade,
                              curve: Curves.linear,
                              reverseCurve: Curves.linear);
                        } else if (conformPassController.text.isEmpty) {
                          showToast(
                              'Please Enter new password'.tr,
                              context: context,
                              animation: StyledToastAnimation.fade,
                              curve: Curves.linear,
                              reverseCurve: Curves.linear);
                        } else {
                          changePasswordBloc.add(ChangePasswordEvent(oldPassword: oldPassController.text, conformPassword: conformPassController.text));
                        }
                      },
                      child: Container(
                          height: width * 0.13,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: AppColors.allButtonColor,
                              boxShadow: [BoxShadow()],
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                              bloc: changePasswordBloc,
                              builder: (context, state) {
                                if(state is ChangePassLoadingState){
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
                                        'RESET'.tr,
                                        style: TextStyle(color: AppColors.whiteColor, fontSize: width * 0.053),
                                      ),
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
                              listener: (context, state) {
                                if(state is ChangePassLoadedState){
                                  showToast(
                                      'Password Updated'.tr,
                                      context: context,
                                      animation: StyledToastAnimation.fade,
                                      curve: Curves.linear,
                                      reverseCurve: Curves.linear);
                                  //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpScreen(
                                  //    email: emailController.text,
                                  //  ),));
                                }
                                else if(state is ChangePassErrorState){
                                  showToast(
                                      'Some error occur'.tr,
                                      context: context,
                                      animation: StyledToastAnimation.fade,
                                      curve: Curves.linear,
                                      reverseCurve: Curves.linear);
                                }
                              },
                            ),
                          )
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
