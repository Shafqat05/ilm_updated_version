abstract class OtpScreenEvent{}
class OtpEvent extends OtpScreenEvent{
  String email;
  String otpCode;
  OtpEvent({required this.email, required this.otpCode});
}