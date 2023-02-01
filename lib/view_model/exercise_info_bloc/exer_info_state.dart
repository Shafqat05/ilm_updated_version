import '../../models/exercise_info_model/exercise_info_model.dart';

abstract class ExerciseInfoState{}
class ExerInfoInitialState extends ExerciseInfoState{}
class ExerInfLoadingState extends ExerciseInfoState{}
class ExerInfoLoadedState extends ExerciseInfoState{
  ExerciseInfoGetModel response;
  ExerInfoLoadedState({required this.response});
}
class ExerInfoErrorState extends ExerciseInfoState{
  String error;
  ExerInfoErrorState({required this.error});
}