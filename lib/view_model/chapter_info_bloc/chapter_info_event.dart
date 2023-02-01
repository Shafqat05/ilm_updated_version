abstract class ChapterInfoScreenEvent{}
class ChapterInfoEvent extends ChapterInfoScreenEvent{
  String? id;
  String? chpNum;
  ChapterInfoEvent({this.id,this.chpNum});
}