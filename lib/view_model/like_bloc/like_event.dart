abstract class LikeScreenEvent{}
class LikeEvent extends LikeScreenEvent{
  String? exId;
  String? bId;
  String? solId;
  String? chpId;
  String? likeDislike;
  LikeEvent({this.likeDislike,this.chpId,this.exId,this.bId,this.solId});
}