abstract class LogoutState{}
class LogoutInitialState extends LogoutState{}
class LogoutLoadingState extends LogoutState{}
class LogoutLoadedState extends LogoutState{
  String response;
  LogoutLoadedState({required this.response});
}
class LogoutErrorState extends LogoutState{
  String error;
  LogoutErrorState({required this.error});
}