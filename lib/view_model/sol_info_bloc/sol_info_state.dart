import '../../models/sol_info_model/sol_info_model.dart';

abstract class SolInfoState{}
class SolInfoInitialState extends SolInfoState{}
class SolInfoLoadingState extends SolInfoState{}
class SolInfoLoadedState extends SolInfoState{
  SolInfoGetModel response;
  SolInfoLoadedState({required this.response});
}
class SolInfoErrorState extends SolInfoState{
  String error;
  SolInfoErrorState({required this.error});
}