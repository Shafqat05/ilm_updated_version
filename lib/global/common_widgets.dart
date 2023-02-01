import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:ilm_updated_version/main.dart';

import '../main.dart';
import 'app_colors.dart';

myCustomAppBar({
  final String? titleAppBar,
  final Widget? backButton,
  final double? fontSize,
  final BuildContext? context
}) {
  return PreferredSize(
    child: Container(
      // margin: EdgeInsets.only(top: 18,left: 5,right: 5),
      height:
      MediaQuery.of(navigatorKey.currentContext!).size.height * 0.06,
      width: MediaQuery.of(navigatorKey.currentContext!).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context!).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.5),
            color: Colors.greenAccent.withOpacity(0.14),
            blurRadius: 0.5,
            spreadRadius: 0.0,
          ),
        ],
      ),
      // color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: backButton,
          ),
          Expanded(
            child: Center(
              child: Text(
                '$titleAppBar',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light ? AppColors.allButtonColor:AppColors.offWhite,
                  fontSize: fontSize,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width:
            MediaQuery.of(navigatorKey.currentContext!).size.width /
                7,
          )
        ],
      ),
    ),
    preferredSize: Size.fromHeight(
        MediaQuery.of(navigatorKey.currentContext!).size.height * 0.075),
  );
}

class MyCustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final IconData? iconA;
  final Color? buttonColors;
  final double? mymargin;
  final Function()? ontap;
  final Widget? myimag;

  const MyCustomButton(
      {Key? key,
        this.height,
        this.width,
        this.text,
        this.iconA,
        this.buttonColors,
        this.mymargin,
        this.ontap,
        this.myimag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: buttonColors,
              boxShadow: [BoxShadow()],
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width! * 0.055,
                ),
                Text(
                  '$text',
                  style: TextStyle(color: AppColors.whiteColor, fontSize: width! * 0.052),
                ),
                //Icon(iconA,size: 28,color: AppColors.whiteColor,),
                Container(
                  height: height! * 0.39,
                  //width: width! * 0.08,
                  child: myimag,
                )
              ],
            ),
          )),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? lable;
  final double? height;
  final double? width;
  final String? myhintText;
  final bool readOnly;
  final bool obsecureText;
  final String? mylabeltext;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixicon;
  final Widget? suffixicon;
  final String? myInitialvalue;

  final TextEditingController? controller;
  CustomTextField(
      {Key? key,
        this.lable,
        this.suffixicon,
        this.height,
        this.width,
        this.myhintText,
        this.controller,
        this.mylabeltext,
        this.keyboardType,
        this.prefixicon,
        this.textInputAction,
        this.myInitialvalue,
        this.readOnly = false,
        this.obsecureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        cursorColor: AppColors.allButtonColor,
        keyboardType: keyboardType,
        initialValue: myInitialvalue,
        obscureText: obsecureText,
        style: TextStyle(fontSize: width! * 0.05,),
        readOnly: readOnly,
        //cursorHeight: 0.5,
        decoration: InputDecoration(
            prefixIcon: prefixicon,
            suffixIcon: suffixicon,
            focusedBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: AppColors.allButtonColor, width: 2.0),
            ),
            labelText: mylabeltext,
            labelStyle: TextStyle(color: AppColors.lightblack2, fontSize: width! * 0.04),
            hintStyle: TextStyle(
              color: Colors.black54,
            )),
      ),
    );
  }
}

void enterFullScreen(FullScreenMode fullScreenMode) async {
  await FullScreen.enterFullScreen(fullScreenMode);
}

void exitFullScreen() async {
  await FullScreen.exitFullScreen();
}