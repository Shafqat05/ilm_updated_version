import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ilm_updated_version/app_utills/api_url.dart';
import 'package:ilm_updated_version/models/sign_up_model/sign_up_get_model.dart';
import 'package:ilm_updated_version/models/sign_up_model/sign_up_post_model.dart';
import 'package:ilm_updated_version/view/screens/bottom_sheet_screen.dart';
import 'package:ilm_updated_version/view/screens/login_signup_screen/login_signup_screen.dart';
import '../../main.dart';
import '../../models/login_model/login_get_model.dart';
import '../../models/login_model/login_post_model.dart';

import 'package:get/get.dart';


import '../../models/social_login_model/social_login_model.dart';
import '../../models/user_detail_model/user_detail_model.dart';


class AccountDataRepository{
  var isLoading = false.obs;

  Future<String> signUpApi({String? fName, String? lName, String? email,String? password, String? phoneNumber, BuildContext? context}) async{
    print('email is == $email');
    print('password is == $password');

    SignUpPostModel signUpPostModel = SignUpPostModel(
      fname: fName,
      lname: lName,
      email: email,
      password: password,
      phonenumber: phoneNumber
    );

    try{
      var response = await http.post(Uri.parse('$baseUrl$signupUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode(signUpPostModel.toJson())
      );
      var data = jsonDecode(response.body);
      print('data is === $data');
      print('response status is ==== ${response.statusCode}');
      SignupGetModel signupGetModel = SignupGetModel.fromJson(data);
      if(signupGetModel.status == 'success'){
        return 'success';
      }
      else{
        return 'Something went wrong';
      }
    } catch(e){}
    finally{
      isLoading(false);
    }

    return '';
  }



  Future<String> login(String email, String password,) async{

    print('email = ${email}');
    print('password = ${password}');
    var isLoading = false.obs;

    LoginPostModel loginPostModel = LoginPostModel(
        email: email,
        password: password,
    );

    try{
      var response = await http.post(Uri.parse('$baseUrl$loginUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(loginPostModel.toJson())
      );
      var data = jsonDecode(response.body);
      print('response status is === ${response.statusCode}');
      print('data is === $data');

      if(data['status'] == 'success'){
        // storage.write('email', data['email']);
        // storage.write('phonenumber', data['phonenumber']);
        storage.write('token',data['auth_key']);
        return 'success';
      }
      else{

        return 'Something went wrong';
      }
    } catch(e) {
      print('error catch ${e.toString()}');
    }
    finally{
      isLoading(false);
    }
    return '';
  }

  Future<String> logout({BuildContext? context}) async{
    try{
      var response = await http.post(Uri.parse('$baseUrl$logoutUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': storage.read('token'),
        },
        body: jsonEncode({
          'lng': 'ar'
        })
      );
      var data = jsonDecode(response.body);
      print('response status is === ${response.statusCode}');
      print('data is === $data');
      if(response.statusCode == 200){
        print('success');
        showToast(
            data['message'],
            context: context,
            animation: StyledToastAnimation.fade,
            curve: Curves.linear,
            reverseCurve: Curves.linear);
        Future.delayed(Duration(seconds: 1),
            (){
              Get.offAll(LoginSignUpScreen());
            }
        );
        return 'success';
      }

    } catch(e){}
    return '';
  }

  Future<String> changePassword({String? oldPassword, String? conformpassword}) async{
    try{
      var response = await http.post(Uri.parse('$baseUrl$changePasswordUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            'old_password': oldPassword,
            'confirm_password': conformpassword,
            'lng': 'en'
          })
      );
      var data = jsonDecode(response.body);
      print('response status is === ${response.statusCode}');
      print('data is === $data');
      if(response.statusCode == 200){
        return 'success';
      }

    } catch(e){}
    return '';
  }

  Future<String> forgotPassword({String? email}) async{
    try{
      var response = await http.post(Uri.parse('$baseUrl$forgotpasswordurl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            //'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            'email': email
          })
      );
      var data = jsonDecode(response.body);
      print('response status is === ${response.statusCode}');
      print('data is === $data');
      if(response.statusCode == 200){
        return 'success';
      }

    } catch(e){}
    return '';
  }

  Future<String> otpVerification({String? email, String? otpCode}) async{

    try{
      var response = await http.post(Uri.parse('$baseUrl$ottpVerificationUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',

          },
          body: jsonEncode({
            'email': email,
            'otpcode': otpCode
          })
      );
      var data = jsonDecode(response.body);
      print('response status is === ${response.statusCode}');
      print('data is === $data');
      if(response.statusCode == 200){
        return 'success';
      }

    } catch(e){}
    return '';
  }

  Future<String> resentOtp({String? email,}) async{

    try{
      var response = await http.post(Uri.parse('$baseUrl$resendOtpurl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': email,
          })
      );
      var data = jsonDecode(response.body);
      print('response status is === ${response.statusCode}');
      print('data is === $data');
      if(response.statusCode == 200){
        return 'success';
      }

    } catch(e){}
    return '';
  }

  Future<String> editProfileMethod({String? firstName, String? lastName}) async{
    try {
      var response = await http.post(Uri.parse('$baseUrl$editProfileUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            'firstname':firstName,
            "lastname":lastName,
            "pic":"",
            "lng":"ar"
          }));
      var data = jsonDecode(response.body);
      print('data is ===== $data');
      print('response status code is ${response.statusCode}');
      if (data['status'] == 'success') {
        return 'success';
      } else {
        return 'Some error occour';
      }
    } catch (e) {
    }
return '';
  }

  Future socialLoginApi({String? email,String? socialType,String? socialId,String? fName,String? lName}) async{
   // SocialLoginModel socialLoginModel;
    try{
      var response = await http.post(Uri.parse('$baseUrl$socialLoginUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
           // 'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            "email":email,
            "social_type":socialType,
            "social_id":socialId,
            "fistname":fName,
            "lastname":lName,
            "lng":"ar"
          }
          ));
      var data = jsonDecode(response.body);
      print('data is ===== $data');
      print('response status code is ${response.statusCode}');
     // socialLoginModel = SocialLoginModel.fromJson(data);
      if (data['status'] == 'success') {
        return 'success';
      } else {
        return 'Some error occour';
      }
    } catch (e){}
  }

  Future userDetail() async{
    try{
      var response = await http.post(Uri.parse('$baseUrl$userDetailUrl'),
        //  headers: map
          headers: <String, String>{
       // 'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
      );
      var data = jsonDecode(response.body);
      print('response status is === ${response.statusCode}');
      print('data is === $data');
      if(data['status'] == 'success'){
        storage.write('email', data['email']);
        storage.write('phonenumber', data['mobile']);
        return 'success';
      }
      else{
        return 'Something went wrong';
      }
    } catch(e) {
      print('error catch ${e.toString()}');
    }
    finally{
      isLoading(false);
    }
    return '';
  }


}