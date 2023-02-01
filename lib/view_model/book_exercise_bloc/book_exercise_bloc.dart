import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book_exercise_model/book_exercise_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'book_exercise_event.dart';
import 'book_exercise_state.dart';

class BookExerciseBloc extends Bloc<BookExerciseScreenEvent,BookExerciseState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  BookExerciseBloc(super.initialState){
    on<BookExerciseEvent>((event, emit) async{
      emit(BookExerciseLoadingState());
      BookExerciseGetModel response = await homeBookRepository.bookExerciseApi(chapId: event.chapId);
      if(response.data != null && response.data!.isNotEmpty && response.data != []){
        emit(BookExerciseLoadedState(response: response));
      }
      else{
        emit(BookExerciseErrorState(error: 'Something went wrong'));
      }
    });
  }
}