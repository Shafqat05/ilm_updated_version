import 'package:flutter/cupertino.dart';

class LoginScreenBehaviour{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void disposeLoginController(){
    emailController.dispose();
    passwordController.dispose();
  }
}