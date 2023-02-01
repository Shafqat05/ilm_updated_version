import '../../models/bookmark_list_model/bookmark_list_get_model.dart';

abstract class BookMarkListState{}
class BookMarkListInitialState extends BookMarkListState{}
class BookMarkListLoadingState extends BookMarkListState{}
class BookMarkListLoadedState extends BookMarkListState{
  BookMarkListGetModel response;
  BookMarkListLoadedState({required this.response});
}
class BookMarkListErrorState extends BookMarkListState{
  String error;
  BookMarkListErrorState({required this.error});
}
