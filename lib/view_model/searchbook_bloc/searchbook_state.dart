import '../../models/searchbook_get_model/searchbook_get_model.dart';

abstract class SearchBookState{}
class SearchBookInitialState extends SearchBookState{}
class SearchBookLoadingState extends SearchBookState{}
class SearchBookLoadedState extends SearchBookState{
  SearchBookGetModel response;
  SearchBookLoadedState({required this.response});
}
class SearchBookErrorState extends SearchBookState{
  String error;
  SearchBookErrorState({required this.error});
}