import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilm_updated_version/view/screens/login_signup_screen/login_signup_screen.dart';
import 'dart:developer';

import '../../global/app_colors.dart';
import 'bottom_sheet_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    getDataBase();
    print('yyyyyyyyyyyyyyyy');
    super.initState();
  }
  getDataBase() async {
    GetStorage storage = GetStorage();
    var token = await storage.read('token');
    log('check token value $token');
    if(token == null || token == ''){
      print('shafqat');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginSignUpScreen(),));

    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomSheetScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: _screenSize.height * 0.12,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 150),
                height: _screenSize.height * 0.36,
                width: _screenSize.width * 0.90,
                color: Colors.white,
                child: Image.asset('assets/splash_img.png'),
              ),
            ),
            SizedBox(
              height: _screenSize.height * 0.010,
            ),
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: _screenSize.width * 0.075),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.transparent,
                    height: _screenSize.height * 0.050,
                    child: Image.asset('assets/ilam.png'),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: _screenSize.height * 0.055,
                    child: Image.asset(
                      'assets/ilam_ur.png',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
