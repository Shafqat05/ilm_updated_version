abstract class OtpState{}
class OtpInitialState extends OtpState{}
class OtpLoadingState extends OtpState{}
class OtpLoadedState extends OtpState{
  String response;
  OtpLoadedState({required this.response});
}
class OtpErrorState extends OtpState{
  String error;
  OtpErrorState({required this.error});
}