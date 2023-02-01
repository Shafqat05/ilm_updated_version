import '../../models/book_info_model/book_info_model.dart';

abstract class BookInfoState{}
class BookInfoInitialState extends BookInfoState{}
class BookInfoLoadingState extends BookInfoState{}
class BookInfoLoadedState extends BookInfoState{
  BookInfoGetModel response;
  BookInfoLoadedState({required this.response});
}
class BookInfoErrorState extends BookInfoState{
  String error;
  BookInfoErrorState({required this.error});
}