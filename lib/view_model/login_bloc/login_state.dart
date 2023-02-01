abstract class LoginState{}
class LoginInitialState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginLoadedState extends LoginState{
  String response;
  LoginLoadedState({required this.response});
}
class LoginErrorState extends LoginState{
  String error;
  LoginErrorState({required this.error });
}