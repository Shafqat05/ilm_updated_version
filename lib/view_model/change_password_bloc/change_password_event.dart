abstract class ChangePasswordScreenEvent{}
class ChangePasswordEvent extends ChangePasswordScreenEvent{
  String oldPassword;
  String conformPassword;
  ChangePasswordEvent({required this.oldPassword, required this.conformPassword});
}