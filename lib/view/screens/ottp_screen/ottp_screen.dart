import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../view_model/otp_bloc/otp_bloc.dart';
import '../../../view_model/otp_bloc/otp_event.dart';
import '../../../view_model/otp_bloc/otp_state.dart';
import '../../../view_model/resentotp_bloc/resentotp_bloc.dart';
import '../../../view_model/resentotp_bloc/resentotp_event.dart';
import '../../../view_model/resentotp_bloc/resentotp_state.dart';

class OtpScreen extends StatefulWidget {
  final String? email;
  const OtpScreen({Key? key, this.email}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  //SignController signController = Get.find<SignController>();
  OtpBloc otpBloc = OtpBloc(OtpInitialState());
  ResentOtpBloc resentOtpBloc = ResentOtpBloc(ResentOtpInitialState());

  var onTapRecognizer;
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";

  bool isOtp = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size _screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: _screensize.height * 0.10,
                ),
                Center(
                  child: Container(
                    height: _screensize.height * 0.35,
                    child: Image.asset(
                      'assets/otpImage.png',

                    ),
                  ),
                ),
                SizedBox(
                  height: _screensize.height * 0.030,
                ),
                Center(
                  child: Text(
                    'Verify Code'.tr,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: _screensize.height*0.010,
                ),
                Text(
                  'Please check your messages & enter the verification code we just sent to you\n${widget.email}'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: _screensize.height*0.040,),
                Form(
                  key: formKey,
                  child: Padding(
                      padding:  EdgeInsets.symmetric(
                          vertical: 9.0, horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: PinCodeTextField(
                        length: 6,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(6),
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        animationType: AnimationType.fade,
                        textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07),
                        validator: (v) {
                          if (v!.length < 3) {
                            return "";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(

                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          inactiveColor: AppColors.offBlackAvatr,
                          inactiveFillColor: AppColors.offBlackAvatr,
                          fieldHeight: MediaQuery.of(context).size.height * 0.07,
                          activeColor: AppColors.offBlackAvatr,
                          fieldWidth: MediaQuery.of(context).size.width * 0.12,
                          activeFillColor:
                          hasError ? AppColors.blackColor : Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.transparent,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        onCompleted: (v) {
                         // myotpController.ottpVerification(mEmail: widget.otpemail,mOttpcode: textEditingController.text);
                          otpBloc.add(OtpEvent(otpCode: textEditingController.text,email: widget.email!));

                        },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                        appContext: context,
                      )),
                ),
                SizedBox(
                  height: _screensize.height*0.030,
                ),
                MyCustomButton(
                  text: 'RESEND'.tr,
                  height: _screensize.height*0.075,
                  width: _screensize.width*0.9,
                  buttonColors: AppColors.blueColor,
                  ontap: () {
                   resentOtpBloc.add(ResentOtpEvent(email: widget.email!));
                  },
                  // myimag: Image.asset('assets/book.png'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
