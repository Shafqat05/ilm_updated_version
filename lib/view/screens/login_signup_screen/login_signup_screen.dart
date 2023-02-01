//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../global/shared_preference_class.dart';
import '../bottom_sheet_screen.dart';
import '../category_book_screen/category_book_screen.dart';
import '../login_screen/login_screen.dart';
import '../signup_screen/signup_screen.dart';
import 'package:get/get.dart';


class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {

  SharedPreferenceClass prefes = SharedPreferenceClass();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size){
      var height = size.maxHeight;
      var width = size.maxWidth;
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Container(
          height: height,
          width: width,
          child: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.350,
                      width: width * 0.46,
                      child: Image.asset('assets/signup_login_img.png'),

                    ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Sign up/Login'.tr,
                            style: TextStyle(
                                fontSize: width * 0.055,
                                color: AppColors.allButtonColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.04,
                            width: width * 0.020,
                          ),
                          MyCustomButton(
                            ontap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),)),
                            height: height * 0.066,
                            width: width * 0.9,
                            buttonColors: AppColors.allButtonColor,
                            text: 'Login'.tr,
                            // iconA: Icons.book,
                            myimag: Image.asset(
                              'assets/book.png',
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          MyCustomButton(
                            height: height * 0.066,
                            width: width * 0.9,
                            buttonColors: AppColors.allButtonColor,
                            text: 'SIGN UP'.tr,
                            myimag: Image.asset(
                              'assets/book.png',
                              color: AppColors.whiteColor,
                            ),
                            ontap: () {
                              print('its is being clicked');
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
                            },
                          ),
                          SizedBox(
                            height: height * 0.030,
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right: width * 0.015),
                            child: Text(
                              'OR'.tr,
                              style: TextStyle(
                                  fontSize: width! * 0.052,
                                  color: AppColors.allButtonColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.030,
                    ),
                    MyCustomButton(
                      height: height * 0.066,
                      width: width * 0.9,
                      buttonColors: AppColors.darkButtonColors,
                      text: 'SKIP'.tr,
                      ontap: () {
                        pushNewScreen(
                          context,
                          screen: BottomSheetScreen(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                        );
                      },
                      // ontap: (){
                      //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomSheetScreen(),));
                      // },
                      // iconA: Icons.book,
                      myimag: Image.asset(
                        'assets/book.png',
                        color: AppColors.whiteColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: height * 0.133,
          width: width,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.040,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // await context.setLocale(Locale('en', 'US'));
                       // prefes.addLocale(en: 'en', dd: 'US');
                        var locale = Locale('en', 'US');
                        Get.updateLocale(locale);
                      },
                      child: Text(
                        'ENGLISH',
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: AppColors.allButtonColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // await context.setLocale(Locale('ar', 'IQ'));
                      //  prefes.addLocale(en: 'ar', dd: 'UAE');
                        //Get.updateLocale(Locale('ar', 'UAE'));
                        var locale = Locale('ar', 'IQ');
                        Get.updateLocale(locale);
                      },
                      child: Text(
                        'العربية',
                        style: TextStyle(
                          fontSize: width * 0.04,
                            color: Colors.black38, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.010,
              ),
              Center(
                child: Text(
                  'Terms and Conditions'.tr,
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.normal,
                      fontSize: width * 0.035),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
