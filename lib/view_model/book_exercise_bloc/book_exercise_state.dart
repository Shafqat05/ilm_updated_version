import '../../models/book_exercise_model/book_exercise_get_model.dart';

abstract class BookExerciseState{}
class BookExerciseInitialState extends BookExerciseState{}
class BookExerciseLoadingState extends BookExerciseState{}
class BookExerciseLoadedState extends BookExerciseState{
  BookExerciseGetModel response;
  BookExerciseLoadedState({required this.response});
}
class BookExerciseErrorState extends BookExerciseState{
  String error;
  BookExerciseErrorState({required this.error});

}