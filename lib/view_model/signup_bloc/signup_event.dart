abstract class SignUpScreenEvent{}
class SignUpEvent extends SignUpScreenEvent{
  String? fName;
  String? lName;
  String? email;
  String? password;
  String? phoneNumber;

  SignUpEvent({this.fName, this.lName, this.email, this.password,  this.phoneNumber});
}