abstract class DeleteCommentState{}
class DelCommentInitialState extends DeleteCommentState{}
class DelCommentLoadingState extends DeleteCommentState{}
class DelCommentLoadedState extends DeleteCommentState{
  String? response;
  DelCommentLoadedState({this.response});
}
class DelCommentErrorState extends DeleteCommentState{
  String? error;
  DelCommentErrorState({this.error});
}