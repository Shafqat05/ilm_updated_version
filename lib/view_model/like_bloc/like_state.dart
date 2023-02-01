abstract class LikeState{}
class LikeInitialState extends LikeState{}
class LikeLoadingState extends LikeState{}
class LikeLoadedState extends LikeState{
  String? response;
  LikeLoadedState({this.response});
}
class LikeErrorState extends LikeState{
  String? error;
  LikeErrorState({this.error});
}