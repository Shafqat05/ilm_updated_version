

abstract class BookMarkListScreenEvent{}
class BookMarkListEvent extends BookMarkListScreenEvent{
  dynamic? bookMarkId;
  BookMarkListEvent({this.bookMarkId});
}