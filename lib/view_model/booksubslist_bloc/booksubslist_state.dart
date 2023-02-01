import '../../models/booksubslist_get_model/booksubslist_get_model.dart';

abstract class BookSubsListState{}
class BookSubsListInitialState extends BookSubsListState{}
class BookSubsListLoadingState extends BookSubsListState{}
class BookSubsListLoadedState extends BookSubsListState{
  BookSubsListGetModel response;
  BookSubsListLoadedState({required this.response});
}
class BookSubsListErrorState extends BookSubsListState{
  String error;
  BookSubsListErrorState({required this.error});
}