abstract class DelCommentScreenEvent{}
class DeleteCommentEvent extends DelCommentScreenEvent{
  String? cId;
  DeleteCommentEvent({this.cId});
}