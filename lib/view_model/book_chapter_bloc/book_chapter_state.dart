import '../../models/book_chapter_model/book_chapter_get_model.dart';

abstract class BookChapterStates{}
class BookChapterInitialState extends BookChapterStates{}
class BookChapterLoadingState extends BookChapterStates{}
class BookChapterLoadedState extends BookChapterStates{
  BookChapterGetModel response;
  BookChapterLoadedState({required this.response});

}
class BookChapterErrorState extends BookChapterStates{
  String error;
  BookChapterErrorState({required this.error});

}