abstract class EditCommentScreenEvent{}
class EditCommentEvent extends EditCommentScreenEvent{
  String? chpId;
  String? comment;
  String? solId;
  EditCommentEvent({this.solId,this.comment,this.chpId});
}