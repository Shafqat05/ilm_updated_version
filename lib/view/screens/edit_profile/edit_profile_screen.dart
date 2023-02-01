import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilm_updated_version/global/shared_preference_class.dart';
import 'package:ilm_updated_version/view/screens/edit_profile/theme_change_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:get/get.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../main.dart';
import '../../../view_model/edit_profile_bloc/edit_profile_bloc.dart';
import '../../../view_model/edit_profile_bloc/edit_profile_event.dart';
import '../../../view_model/edit_profile_bloc/edit_profile_states.dart';
import '../../../view_model/logout_bloc/logout_bloc.dart';
import '../../../view_model/logout_bloc/logout_event.dart';
import '../../../view_model/logout_bloc/logout_state.dart';
import '../../../view_model/signup_bloc/signup_bloc.dart';
import '../../../view_model/signup_bloc/signup_event.dart';
import '../../../view_model/signup_bloc/signup_states.dart';
import '../change_password_screen/change_password_screen.dart';
import '../my_subscription_screen/my_subscription_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  LogoutBloc logoutBloc = LogoutBloc(LogoutInitialState());
  EditProfileBloc editProfileBloc = EditProfileBloc(EditProfileInitialState());
  SignUpBloc signUpBloc = SignUpBloc(SignupInitialState());

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool _lights = false;
  bool mode = true;
  XFile? image;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  SharedPreferenceClass prefes = SharedPreferenceClass();
  bool _value = false;

  @override
  void initState() {
   // GetStorage storage = GetStorage();
    emailController = TextEditingController(text: storage.read('email'));
    phoneController = TextEditingController(text: storage.read('phonenumber'));
    //signUpBloc.add(SignUpEvent(email: emailController.text,phoneNumber: phoneController.text));
    super.initState();
  }

  @override
  void dispose() {
    emailController.clear();
    phoneController.clear();
    super.dispose();
  }

//........... To set a image picker From Camera......................//
  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 80,
    );

    setState(() {
      image = pickedFile;
    });
  }

//............................ Select From Gallery................//

  Future getImageGalary() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 80,
    );

    setState(() {
      image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _formKey,
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: width * 0.02, top: height * 0.010,right: width * 0.02),
                        height: height * 0.06,
                        width: width * 0.96,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.allButtonColor
                                      .withOpacity(0.14),
                                  offset: Offset(1, 2),
                                  blurRadius: 4,
                                  spreadRadius: 2)
                            ],
                            color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ToggleSwitch(
                              minHeight: height * 0.045,
                              minWidth: width * 0.15,
                              initialLabelIndex: 0,
                              cornerRadius: 4,
                              totalSwitches: 2,
                              labels: [
                                'ENG',
                                'العربية',
                              ],
                              activeBgColor: [AppColors.allButtonColor],
                              inactiveBgColor: Colors.grey.withOpacity(0.7),
                              customTextStyles: [
                                TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                ),
                                TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.035,
                                )
                              ],
                              onToggle: (index) async {
                                print('switched to: $index');
                                if (index == 0) {
                                  // await context.setLocale(Locale('en', 'US'));
                                  var locale = Locale('en', 'US');
                                  Get.updateLocale(locale);

                                } else {
                                  // await context.setLocale(Locale('ar', 'IQ'));
                                  var locale = Locale('ar', 'IQ');
                                  Get.updateLocale(locale);
                                }
                              },

                            ),
                            Text(
                              'My Profile'.tr,
                              style: TextStyle(
                                  color: AppColors.allButtonColor,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w600),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  GetStorage storage = GetStorage();

                                  logoutBloc.accountDataRepository
                                      .logout(context: context);
                                  storage.erase();
                                  // Navigator.pushReplacement(context!, MaterialPageRoute(builder: (context) => LoginSignUpScreen(),));
                                },
                                child: BlocConsumer<LogoutBloc, LogoutState>(
                                  bloc: logoutBloc,
                                  builder: (context, state) {
                                    if (state is LogoutLoadingState) {
                                      return Text('');
                                    } else {
                                      return Icon(
                                        Icons.settings_power,
                                        color: AppColors.allButtonColor,
                                        size: width * 0.07,
                                      );
                                    }
                                  },
                                  listener: (context, state) {
                                    // if(state is LogoutLoadedState){
                                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSignUpScreen(),));
                                    // }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: Container(
                                height: height * 0.28,
                                width: width * 0.26,
                                color: Colors.white,
                                child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width,
                                      height: height * 0.06,
                                      color: Colors.black,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Add Photo!'.tr,
                                              style: TextStyle(
                                                  color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor: AppColors.whiteColor,
                                                  fontSize: width * 0.05),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.040,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: width * 0.040),
                                        GestureDetector(
                                            onTap: () {
                                              // capturFromCamera();
                                              getImage();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Take Photo'.tr,
                                              style: TextStyle(
                                                color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.blackColor,
                                                  fontSize: width * 0.047),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.030,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: width * 0.040),
                                        GestureDetector(
                                          child: Text(
                                            'Chose from Library'.tr,
                                            style: TextStyle(
                                                color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.blackColor,
                                                fontSize: width * 0.047),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                )),
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    height: height * 0.28,
                                                    width: width,
                                                    child: Column(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height: height *
                                                                  0.060,
                                                            ),
                                                            Text(
                                                              'Select Picture'.tr,
                                                              style: TextStyle(
                                                                  color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.whiteColor,
                                                                  fontSize:
                                                                      width *
                                                                          0.07,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.060,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width * 0.050,
                                                            ),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  getImageGalary();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .photo_library,
                                                                  size: width *
                                                                      0.11,
                                                                )),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: width *
                                                                      0.12,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    getImageGalary();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Icon(
                                                                    Icons.image,
                                                                    size: width *
                                                                        0.11,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.020,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width * 0.040,
                                                            ),
                                                            Text(
                                                              'Albums'.tr,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      width *
                                                                          0.04),
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: width *
                                                                      0.12,
                                                                ),
                                                                Text(
                                                                  'Photos'.tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          width *
                                                                              0.04),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.040,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: width * 0.040),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel'.tr,
                                              style: TextStyle(
                                                  color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.blackColor,
                                                  fontSize: width * 0.047),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                        //.......show edit profile work..............//
                        child: Container(
                          height: height * 0.13,
                          width: width * 0.26,
                          child: image == null
                              ? Image.asset(
                                  'assets/boy.png',
                                  fit: BoxFit.fill,
                                )
                              : CircleAvatar(
                                  foregroundImage: FileImage(
                                    File(image!.path),
                                  ),
                                ),
                        ),
                      ),
                      Container(
                          height: height * 0.03,
                          width: width * 0.05,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          margin: EdgeInsets.only(
                              top: height * 0.088, left: width * 0.2),
                          child: Image.asset(
                            'assets/edit.png',
                            fit: BoxFit.fill,
                          ))
                    ],
                  ),
                  Container(
                    height: height * 0.80,
                    child: Column(
                      //scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.055, top: height * 0.02,right: width * 0.055),
                          child: Row(
                            children: [
                              Text(
                                'Edit Profile'.tr,
                                style: TextStyle(
                                    color: AppColors.allButtonColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.045),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.020,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.055,right: width * 0.055),
                          child: Row(
                            children: [
                              Text(
                                'Email'.tr,
                                style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.40) : AppColors.textColor,
                                    fontSize: width * 0.045),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: width * 0.06,
                            right: width * 0.06
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      // child: Icon(
                                      //   Icons.add,
                                      //   size: 20,
                                      // ),
                                    ),
                                    CustomTextField(
                                      width: width * 0.8,
                                      //mylabeltext: 'Contact Number',
                                      // keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      // prefixicon: Icon(Icons.add),
                                      controller: emailController,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.055,right: width * 0.055),
                          child: Row(
                            children: [
                              Text(
                                'Contact Number'.tr,
                                style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.40) : AppColors.textColor,
                                    fontSize: width * 0.045),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: width * 0.06,
                            right: width * 0.06
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      // child: Icon(
                                      //   Icons.add,
                                      //   size: 20,
                                      // ),
                                    ),
                                    CustomTextField(
                                      width: width * 0.8,
                                      //mylabeltext: 'Contact Number',
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      // prefixicon: Icon(Icons.add),
                                      controller: phoneController,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: width * 0.050, right: width * 0.050,left: width * 0.050),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (emailController.text.isEmpty) {
                                    showToast('Please Enter email'.tr,
                                        context: context,
                                        animation: StyledToastAnimation.fade,
                                        curve: Curves.linear,
                                        reverseCurve: Curves.linear);
                                  } else if (phoneController.text.isEmpty) {
                                    showToast('Please Enter phone number'.tr,
                                        context: context,
                                        animation: StyledToastAnimation.fade,
                                        curve: Curves.linear,
                                        reverseCurve: Curves.linear);
                                  } else {
                                    editProfileBloc.add(EditProfileEvent(
                                        firstName: emailController.text,
                                        lastName: phoneController.text));
                                  }
                                  // emailController.clear();
                                  // phoneController.clear();
                                },
                                child: Container(
                                  height: height * 0.06,
                                  width: width * 0.15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: AppColors.allButtonColor),
                                  child: Center(
                                      child: BlocConsumer<EditProfileBloc,
                                          EditProfileState>(
                                    bloc: editProfileBloc,
                                    builder: (context, state) {
                                      if (state is EditProfileLoadingState) {
                                        return Center(
                                          child: Center(
                                              child: SpinKitFadingCircle(
                                            size: 50,
                                            color: AppColors.circlepicker,
                                          )),
                                        );
                                      } else {
                                        return Text(
                                          'Save'.tr,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.045),
                                        );
                                      }
                                    },
                                    listener: (context, state) {
                                      if (state is EditProfileLoadedState) {
                                        showToast('Data Saved'.tr,
                                            context: context,
                                            animation:
                                                StyledToastAnimation.fade,
                                            curve: Curves.linear,
                                            reverseCurve: Curves.linear);
                                      }
                                    },
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.050, top: width * 0.023,left:width * 0.050),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pushNewScreen(
                                    context,
                                    screen: ChangePasswordScreen(),

                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.slideUp,
                                  );
                                },
                                child: Text(
                                  'Reset Password'.tr,
                                  style: TextStyle(
                                      color: AppColors.allButtonColor,
                                      fontSize: width * 0.045),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            // height: height * 0.010,
                            ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => MySubscriptionScreen());
                              },
                              child: Container(
                                  width: width * 0.61,
                                  height: height * 0.09,
                                  child: Image.asset(
                                    'assets/my_subscriptions_btn.png',
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                width: width * 0.61,
                                height: height * 0.09,
                                child: Image.asset(
                                    fit: BoxFit.fill,
                                    'assets/contact_us_btn.png'))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton:
        // FloatingActionButton.extended(
        //     onPressed: () {},
        //     label: Text('Switch Theme',style: TextStyle(color: Colors.black),),
        //   icon: Icon(Icons.brightness_high,color: Colors.black,),
        // ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ThemeChangeScreen(),));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Theme Change'.tr,
                style: TextStyle(
                    fontSize: width * 0.045, fontWeight: FontWeight.bold,color: AppColors.allButtonColor),
              ),
             SizedBox(width: width * 0.005,),
             Icon(Icons.arrow_forward_ios,color: AppColors.allButtonColor,size: width * 0.04,)

              // Padding(
              //   padding: EdgeInsets.only(left: width * 0.020),
              //   child: CupertinoSwitch(
              //     value: _value,
              //     onChanged: ( value) {
              //       setState(() {
              //         _value = value;
              //         if (_value)
              //           MyApp.of(context)!.changeTheme(ThemeMode.dark);
              //         else
              //           MyApp.of(context)!.changeTheme(ThemeMode.light);
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
