import '../../models/chapter_exercise_model/chapter_ex_get_model.dart';

abstract class ChapterExerciseState{}
class ChapterExInitialState extends ChapterExerciseState{}
class ChapterExLoadingState extends ChapterExerciseState{}
class ChapterExLoadedState extends ChapterExerciseState{
  ChapterExGetModel response;
  ChapterExLoadedState({required this.response});
}
class ChapterExErrorState extends ChapterExerciseState{
  String error;
  ChapterExErrorState({required this.error});

}