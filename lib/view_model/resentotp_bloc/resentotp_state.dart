abstract class ResentOtpState{}
class ResentOtpInitialState extends ResentOtpState{}
class ResentOtpLoadingState extends ResentOtpState{}
class ResentOtpLoadedState extends ResentOtpState{
  String response;
  ResentOtpLoadedState({required this.response});
}
class ResentOtpErrorState extends ResentOtpState{
  String error;
  ResentOtpErrorState({required this.error});
}