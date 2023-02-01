import 'package:flutter/cupertino.dart';

class SignUpBehaviour{
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();

  // disposeSignUpController(){
  //   fNameController.dispose();
  //   lNameController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   phoneNumController.dispose();
  // }

  Widget customToast(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.080,
      width: MediaQuery.of(context).size.width * 0.250,
    );
  }
}