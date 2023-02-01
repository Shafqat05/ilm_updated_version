import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book_info_model/book_info_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'book_info_event.dart';
import 'book_info_state.dart';

class BookInfoBloc extends Bloc<BookInfoScreenEvent, BookInfoState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  BookInfoBloc(super.initialState){
    on<BookInfoEvent>((event, emit) async{
      emit(BookInfoLoadingState());
      BookInfoGetModel response = await homeBookRepository.bookInfoApi(bookId: event.bookId);
      if(response != null ){
        emit(BookInfoLoadedState(response: response));
      }
      else{
        emit(BookInfoErrorState(error: 'Some error occour'));
      }
    });
  }
}