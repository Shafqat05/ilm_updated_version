import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book_ex_question_get_model/book_ex_question_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'book_ex_ques_event.dart';
import 'book_ex_question_state.dart';

class BookExQuestionBloc extends Bloc<BookExQuestionScreenEvent, BookExQuestionState>{

  HomeBookRepository homeBookRepository = HomeBookRepository();

  BookExQuestionBloc(super.initialState){
    on<BookExQuestionEvent>((event, emit) async{
      emit(BookExQuesLoadingState());
      BookExQuesGetModel response = await homeBookRepository.bookExQuestionApi(id: event.id);
      if(response.data != null && response.data!.isNotEmpty && response.data != []){
        emit(BookExQuesLoadedState(response: response));
      }
      else{
        emit(BookExQuesErrorState(error: 'Something went wrong'));
      }
    } );
  }

}