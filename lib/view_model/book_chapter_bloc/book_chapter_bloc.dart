import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book_chapter_model/book_chapter_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'book_chapter_event.dart';
import 'book_chapter_state.dart';

class BookChapterBloc extends Bloc<BookChapterScreenEvent, BookChapterStates>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  BookChapterBloc(super.initialState){
    on<BookChapterEvent>((event, emit) async{
      emit(BookChapterLoadingState());
      BookChapterGetModel response = await homeBookRepository.bookChapterApi(chapterId: event.chapterId);
      if(response.data != null && response.data!.isNotEmpty && response.data != []){
        emit(BookChapterLoadedState(response: response));
      }
      else{
        emit(BookChapterErrorState(error: 'Something went wrong'));
      }
    });
  }

}