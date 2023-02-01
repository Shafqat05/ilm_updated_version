abstract class BookByCatIdScreenEvent{

}
class BookByCatIdEvent extends BookByCatIdScreenEvent{
  dynamic? CartId;
  BookByCatIdEvent({this.CartId});
}