abstract class ForgotPassScreenEvent{}
class ForgotPasswordEvent extends ForgotPassScreenEvent{
  String email;
  ForgotPasswordEvent({required this.email});
}