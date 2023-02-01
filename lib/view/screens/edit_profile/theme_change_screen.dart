import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../main.dart';
import 'edit_profile_screen.dart';

class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  bool _value = false;
  bool _valuee = false;
    ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: myCustomAppBar(
            backButton: BackButton(
              color: AppColors.allButtonColor,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => EditProfileScreen(),));
              },
            ),
            titleAppBar: 'Theme Change'.tr,
            context: context,
            fontSize: width * 0.045),

        body: Column(
          children: [
            SizedBox(height: height * 0.06,),
            GestureDetector(
              onTap: () {
                setState(() {
                 // if(themeMode == ThemeMode.light){
                 //   MyApp.of(context)!.changeTheme(ThemeMode.dark);
                 // }

                });
              },
              child: Padding(
                padding:  EdgeInsets.only(left: width * 0.03,right: width * 0.03),
                child: Container(
                  height: height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          'Dark Theme'.tr,
                        style: TextStyle(color: AppColors.allButtonColor,fontSize: width * 0.05),
                      ),
                      Switch(
                        value: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            if (_value == true)
                              MyApp.of(context)!.changeTheme(ThemeMode.dark);
                            else
                              MyApp.of(context)!.changeTheme(ThemeMode.light);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.015,),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //     // if(_value == false){
            //     //   MyApp.of(context)!.changeTheme(ThemeMode.light);
            //     // }
            //     });
            //   },
            //   child: Padding(
            //     padding:  EdgeInsets.only(left: width * 0.03,right: width * 0.03),
            //     child: Container(
            //       height: height * 0.05,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Light Theme',
            //             style: TextStyle(color: AppColors.allButtonColor,fontSize: width * 0.05),
            //           ),
            //           Switch(
            //             value: _valuee,
            //             onChanged: (value) {
            //               setState(() {
            //                 _valuee = value;
            //                 if (_valuee==true)
            //                   MyApp.of(context)!.changeTheme(ThemeMode.light);
            //                 else
            //                   MyApp.of(context)!.changeTheme(ThemeMode.dark);
            //               });
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
