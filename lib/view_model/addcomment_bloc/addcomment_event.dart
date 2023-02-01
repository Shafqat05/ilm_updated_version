abstract class AddCommentScreenEvent{}
class AddCommentEvent extends AddCommentScreenEvent{
  String? exId;
  String? chpId;
  String? bId;
  String? comment;
  String? solId;
  AddCommentEvent({this.exId,this.solId,this.bId,this.chpId,this.comment});
}