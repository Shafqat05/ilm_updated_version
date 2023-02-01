abstract class EditCommentState{}
class EditCommentInitialState extends EditCommentState{}
class EditCommentLoadingState extends EditCommentState{}
class EditCommentLoadedState extends EditCommentState{
  String? response;
  EditCommentLoadedState({this.response});
}
class EditCommentErrorState extends EditCommentState{
  String? error;
  EditCommentErrorState({this.error});
}