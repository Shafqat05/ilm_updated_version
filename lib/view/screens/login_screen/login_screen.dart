import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ilm_updated_version/view/screens/signup_screen/signup_screen.dart';
import 'package:ilm_updated_version/view_model/login_bloc/login_bloc.dart';
import 'package:ilm_updated_version/view_model/login_bloc/login_state.dart';
import 'package:ilm_updated_version/view_model/login_bloc/login_events.dart';
import 'package:get/get.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../main.dart';
import '../../../repository/accounts_data_repo/accounts_data_repository.dart';
import '../../../view_model/user_detail_bloc/user_detail_bloc.dart';
import '../../../view_model/user_detail_bloc/user_detail_event.dart';
import '../../../view_model/user_detail_bloc/user_detail_state.dart';
import '../bottom_sheet_screen.dart';
import '../category_book_screen/category_book_screen.dart';
import '../forgot_password_screen/forgot_password_screen.dart';
import 'login_behaviour.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginScreenBehaviour {
  LoginScreenBloc loginScreenBloc = LoginScreenBloc(LoginInitialState());
  UserDetailBloc userDetailBloc = UserDetailBloc(UserDetailInitialState());
  AccountDataRepository accountDataRepository = AccountDataRepository();

  @override
  void dispose() {
    disposeLoginController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, size){
        var height = size.maxHeight;
        var width = size.maxWidth;
        return Scaffold(
          body: Stack(
            children: [
              ListView(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.010,
                        ),
                        Container(
                          height: height * 0.32,
                          width: width * 0.46,
                          child: Image.asset('assets/signup_login_img.png'),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: width * 0.035,right: width * 0.035),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Login'.tr,
                                style: TextStyle(
                                    color: AppColors.allButtonColor,
                                    fontSize: width * 0.06,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.024,
                        ),
                        Container(
                          child: CustomTextField(
                            width: width * 0.93,
                            mylabeltext: 'Email/Phone Number'.tr,
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.024,
                        ),
                        Container(
                          child: CustomTextField(
                            width: width * 0.93,
                            mylabeltext: 'Password'.tr,
                            textInputAction: TextInputAction.next,
                            controller: passwordController,
                            obsecureText: true,

                          ),
                        ),
                        SizedBox(
                          height: height * 0.024,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.67),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),));
                            },
                            child: Text(
                              'Forgot Password?'.tr,
                              style:
                              TextStyle(fontSize: width * 0.039, color: AppColors.lightblack2),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.040),
                        GestureDetector(
                          onTap: ()async{


                            if (emailController.text.isEmpty) {
                              showToast(
                                  'Please Enter email'.tr,
                                  context: context,
                                  animation: StyledToastAnimation.fade,
                                  curve: Curves.linear,
                                  reverseCurve: Curves.linear);
                            } else if (passwordController.text.isEmpty) {
                              showToast(
                                  'Please Enter password'.tr,
                                  context: context,
                                  animation: StyledToastAnimation.fade,
                                  curve: Curves.linear,
                                  reverseCurve: Curves.linear);
                            }else{
                              print('token............${storage.read('token')}');
                               loginScreenBloc.add(LoginEvents(email: emailController.text, password: passwordController.text));
                               Future.delayed(Duration(seconds: 1)).then((value) => accountDataRepository.userDetail(
                               //     map: {
                               //  // 'Content-Type': 'application/json; charset=UTF-8',
                               //   'Authorization': storage.read('token'),
                               // }
                               ));



                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomSheetScreen(),));
                            }

                          },
                          child: Container(
                              height: height * 0.066,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color:AppColors.allButtonColor,
                                  boxShadow: [BoxShadow()],
                                  borderRadius: BorderRadius.circular(30)),
                              child: BlocConsumer<LoginScreenBloc, LoginState>(
                                bloc: loginScreenBloc,
                                builder: (context, state) {
                                  if(state is LoginLoadingState){
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
                                      BoxDecoration(color: Colors.black.withOpacity(0.2)),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 30, left: 30),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * 0.055,
                                        ),
                                        Text(
                                          'Login'.tr,
                                          style: TextStyle(color: AppColors.whiteColor, fontSize: width * 0.06),
                                        ),
                                        //Icon(iconA,size: 28,color: AppColors.whiteColor,),
                                        Container(
                                          height: height * 0.39,
                                          child: Image.asset(
                                            'assets/book.png',
                                            color: AppColors.whiteColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                listener: (context, state) {
                                  if(state is LoginLoadedState){

                                  }
                                  else if(state is LoginErrorState){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some error occour'.tr)));
                                  }
                                },
                              )
                          ),
                        ),
                        SizedBox(
                          height: height * 0.030,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'or Sign in using'.tr,
                              style: TextStyle(
                                  fontSize: width * 0.044, color: AppColors.blackColor),
                            ),
                          ],
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height * 0.12,
                              width: width * 0.16,
                              child: Image.asset('assets/google.png'),

                            ),
                            SizedBox(
                              width: width * 0.030,
                            ),
                            Container(
                              height: height * 0.12,
                              width: width * 0.16,
                              child: Image.asset('assets/fb.png'),

                            ),
                            SizedBox(
                              width: width * 0.020,
                            ),
                            Container(
                              height: height * 0.12,
                              width: width * 0.16,
                              child: Image.asset('assets/twitter.png'),

                            ),
                            SizedBox(
                              width: width * 0.020,
                            ),
                            Container(
                              height: height * 0.12,
                              width: width * 0.16,
                              child: Image.asset('assets/insta.png'),

                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.010,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do not have an account?'.tr,
                              style: TextStyle(
                                  color: AppColors.lightblack2, fontSize: width * 0.042),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                                },
                                child: Text(
                                  'Sign Up'.tr,
                                  style: TextStyle(
                                      color: AppColors.allButtonColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.043),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Text(
                          'Terms and Conditions'.tr,
                          style: TextStyle(
                              color: AppColors.lightblack2, fontSize: width * 0.041),
                        ),
                        SizedBox(
                          height: height * 0.010,
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
