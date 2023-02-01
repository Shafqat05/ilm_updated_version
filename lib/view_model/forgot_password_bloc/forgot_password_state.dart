abstract class ForgotPasswordState{}
class ForgotPassInitialState extends ForgotPasswordState{}
class ForgotPassLoadingState extends ForgotPasswordState{}
class ForgotPassLoadedState extends ForgotPasswordState{
  String response;
  ForgotPassLoadedState({required this.response});
}
class ForgotPassErrorState extends ForgotPasswordState{
  String error;
  ForgotPassErrorState({required this.error});
}