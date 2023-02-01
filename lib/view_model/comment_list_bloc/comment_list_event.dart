abstract class CommentListScreenEvent{}
class CommentListEvent extends CommentListScreenEvent{
  String? exId;
  String? solId;
  CommentListEvent({this.solId, this.exId});
}