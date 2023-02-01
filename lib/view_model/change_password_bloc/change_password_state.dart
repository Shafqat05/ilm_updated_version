abstract class ChangePasswordState{}
class ChangePassInitialState extends ChangePasswordState{}
class ChangePassLoadingState extends ChangePasswordState{}
class ChangePassLoadedState extends ChangePasswordState{
  String response;
  ChangePassLoadedState({required this.response});
}
class ChangePassErrorState extends ChangePasswordState{
  String error;
  ChangePassErrorState({required this.error});
}