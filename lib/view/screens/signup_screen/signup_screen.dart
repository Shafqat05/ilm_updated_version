import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ilm_updated_version/view/screens/signup_screen/signup_behaviour.dart';
import 'package:ilm_updated_version/view_model/signup_bloc/signup_bloc.dart';
import 'package:ilm_updated_version/view_model/signup_bloc/signup_event.dart';
import 'package:ilm_updated_version/view_model/signup_bloc/signup_states.dart';
import 'package:flutter_bloc/src/bloc_consumer.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../login_screen/login_screen.dart';
import '../ottp_screen/ottp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SignUpBehaviour {
  SignUpBloc signUpBloc = SignUpBloc(SignupInitialState());
  bool isObsecured = true;

  // @override
  // void dispose() {
  //  disposeSignUpController();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size){
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
                        padding:  EdgeInsets.only(left: width * 0.033,right: width * 0.033),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Sign Up'.tr,
                              style: TextStyle(
                                  color: AppColors.allButtonColor,
                                  fontSize: width * 0.055,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0030,
                      ),
                      Container(
                        child: CustomTextField(
                          width: width * 0.93,
                          mylabeltext: 'First Name'.tr,
                          controller: fNameController,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Container(
                        child: CustomTextField(
                            width: width * 0.93,
                            mylabeltext: 'Last Name'.tr,
                            textInputAction: TextInputAction.next,
                            controller: lNameController),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Container(
                        child: CustomTextField(
                          width: width * 0.93,
                          mylabeltext: 'Email'.tr,
                          textInputAction: TextInputAction.next,
                          controller: emailController,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Container(
                        width: width * 0.93,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          cursorColor: AppColors.buttoncolore,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.buttoncolore, width: 2.0),
                              ),
                              labelText: 'Phone Number (Optional)'.tr,
                              labelStyle: TextStyle(color: AppColors.lightblack2, fontSize: width * 0.04),
                              hintStyle: TextStyle(color: Colors.black54)),
                          controller: phoneNumController,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Container(
                        child: CustomTextField(
                          width: width * 0.93,
                          mylabeltext: 'Password'.tr,
                          textInputAction: TextInputAction.next,
                          controller: passwordController,
                          obsecureText: isObsecured,
                          suffixicon: Padding(
                            padding:  EdgeInsets.only(bottom: height * 0.01,right: width * 0.02),
                            child: IconButton(
                              icon: Icon(
                                isObsecured ?  Icons.visibility_off : Icons.visibility,
                                size: width * 0.06,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObsecured = !isObsecured;
                                });
                              },
                            ),
                          ),


                        ),
                      ),
                      SizedBox(),
                      SizedBox(height: height * 0.0280),
                      GestureDetector(
                        onTap: (){
                          if (fNameController.text.isEmpty) {
                            showToast(
                                'Please Enter first name'.tr,
                                context: context,
                                animation: StyledToastAnimation.fade,
                                curve: Curves.linear,
                                reverseCurve: Curves.linear);
                          } else if (lNameController.text.isEmpty) {
                            showToast(
                                'Please Enter last name'.tr,
                                context: context,
                                animation: StyledToastAnimation.fade,
                                curve: Curves.linear,
                                reverseCurve: Curves.linear);
                          } else if (emailController.text.isEmpty) {
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
                          } else {
                            signUpBloc.add(SignUpEvent(fName: fNameController.text, lName: lNameController.text, email: emailController.text, password: passwordController.text, phoneNumber: phoneNumController.text));
                          }
                        },
                        child: Container(
                            height: height * 0.066,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                                color:AppColors.allButtonColor,
                                boxShadow: [BoxShadow()],
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                                padding: const EdgeInsets.only( left: 30,right: 30),
                              child: BlocConsumer<SignUpBloc, SignupState>(
                                bloc: signUpBloc,
                                builder: (context, state) {
                                  if(state is SignupLoadingState){
                                    return Center(
                                        child: SpinKitFadingCircle(
                                          size: 50,
                                          color: AppColors.circlepicker,
                                        )
                                    );
                                  }
                                  else{
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * 0.055,
                                        ),
                                        Text(
                                          'Sign Up'.tr,
                                          style: TextStyle(color: AppColors.whiteColor, fontSize: width * 0.05),
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
                                    );
                                  }
                                },
                                listener: (context, state) {
                                  if(state is SignupLoadedState){
                                    showToast(
                                        'Account created successfully'.tr,
                                        context: context,
                                        animation: StyledToastAnimation.fade,
                                        curve: Curves.linear,
                                        reverseCurve: Curves.linear);
                                   //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpScreen(
                                   //    email: emailController.text,
                                   //  ),));
                                  }
                                  else if(state is SignupErrorState){
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
                      ),
                      SizedBox(
                        height: height * 0.030,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?'.tr,
                            style: TextStyle(
                                color: AppColors.lightblack2, fontSize: width * 0.04),
                          ),
                          InkWell(
                            onTap: () {
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                            },
                            child: Text(
                              'Login'.tr,
                              style: TextStyle(
                                  color: AppColors.allButtonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.020,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Terms and Conditions'.tr,
                            style: TextStyle(
                                color: AppColors.lightblack2, fontSize: width * 0.044),
                          )
                        ],
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
    });
  }
}
