

abstract class UserDetailState{}
class UserDetailInitialState extends UserDetailState{}
class UserDetailLoadingState extends UserDetailState{}
class UserDetailLoadedState extends UserDetailState{
  String response;
  UserDetailLoadedState({required this.response});
}
class UserDetailErrorState extends UserDetailState{
  String error;
  UserDetailErrorState({required this.error});
}