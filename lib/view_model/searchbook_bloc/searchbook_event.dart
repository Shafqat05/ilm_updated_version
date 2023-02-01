abstract class SearchBookScreenEvent{}
class SearchBookEvent extends SearchBookScreenEvent{
  String? isbn;
  String? bookName;
  String? bookAuthor;
  String? searchkeyword;
  SearchBookEvent({this.isbn,  this.bookName,  this.bookAuthor,  this.searchkeyword});
}