abstract class ExerInfoScreenEvent{}
class ExerInfoEvent extends ExerInfoScreenEvent{
  String? exId;
  String? bookId;
  String? chpId;
  ExerInfoEvent({this.exId, this.chpId,this.bookId});
}