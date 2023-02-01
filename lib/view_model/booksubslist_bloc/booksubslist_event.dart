abstract class BookSubsListScreenEvent{}
class BookSubsListEvent extends BookSubsListScreenEvent{
  String? subsBookId;
  BookSubsListEvent({this.subsBookId});
}