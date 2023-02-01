abstract class AddCommentState{}
class AddCommentInitialState extends AddCommentState{}
class AddCommentLoadingState extends AddCommentState{}
class AddCommentLoadedState extends AddCommentState{
  String response;
  AddCommentLoadedState({required this.response});
}
class AddCommentErrorState extends AddCommentState{
  String error;
  AddCommentErrorState({required this.error});
}