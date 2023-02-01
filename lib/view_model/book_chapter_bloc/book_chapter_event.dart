abstract class BookChapterScreenEvent{}
class BookChapterEvent extends BookChapterScreenEvent{
  dynamic? chapterId;
  BookChapterEvent({this.chapterId});
}