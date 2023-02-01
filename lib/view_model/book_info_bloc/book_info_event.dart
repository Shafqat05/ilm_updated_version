abstract class BookInfoScreenEvent{}
class BookInfoEvent extends BookInfoScreenEvent{
  String? bookId;
  BookInfoEvent({this.bookId});
}