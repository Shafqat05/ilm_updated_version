abstract class BookExerciseScreenEvent{}
class BookExerciseEvent extends BookExerciseScreenEvent{
  dynamic? chapId;
  BookExerciseEvent({this.chapId});
}