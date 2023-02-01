import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'bookmark_event.dart';
import 'bookmark_states.dart';

class BookMarkBloc extends Bloc<BookMarkScreenEvent, BookMarkState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  String response = '';
  BookMarkBloc(super.initialState){
    on<BookMarkEvent>((event, emit) async{
      emit(BookMarkLoadingState());
      response = await homeBookRepository.bookMarksApi(
        chapId: event.chapId,
        bookId: event.bookId,
        bookMarkId: event.bookMarkId,
        chpteNum: event.chpteNum,
        exId: event.exId,
        exNum: event.exNum,
        quesNum: event.quesNum
      );
      if(response == 'success'){
        emit(BookMarkLoadedState(response: response));
      }
      else{
        emit(BookMarkErrorState(error: response));
      }
    });
  }

}