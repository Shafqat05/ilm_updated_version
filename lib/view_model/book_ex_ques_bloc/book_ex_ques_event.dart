abstract class BookExQuestionScreenEvent{}
class BookExQuestionEvent extends BookExQuestionScreenEvent{
  dynamic? id;
  BookExQuestionEvent({this.id});
}