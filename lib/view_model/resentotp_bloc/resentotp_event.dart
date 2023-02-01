abstract class ResentOtpScreenEvent{}
class ResentOtpEvent extends ResentOtpScreenEvent{
  String email;
  ResentOtpEvent({required this.email});
}