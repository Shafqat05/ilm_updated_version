abstract class BookSubscScreenEvent{}
class BookSubscriptionEvent extends BookSubscScreenEvent{
  dynamic? bookId;
  BookSubscriptionEvent({this.bookId});
}