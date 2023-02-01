abstract class CheckSubsState{}
class CheckSubsInitialState extends CheckSubsState{}
class CheckSubsLoadingState extends CheckSubsState{}
class CheckSubsLoadedState extends CheckSubsState{
  String? response;
  CheckSubsLoadedState({this.response});
}
class CheckSubsErrorState extends CheckSubsState{
  String? error;
  CheckSubsErrorState({this.error});
}