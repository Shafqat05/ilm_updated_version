abstract class SignupState{}
class SignupInitialState extends SignupState{}
class SignupLoadingState extends SignupState{}
class SignupLoadedState extends SignupState{
  String response;
  SignupLoadedState({required this.response});
}
class SignupErrorState extends SignupState{
  String error;
  SignupErrorState({required this.error });
}