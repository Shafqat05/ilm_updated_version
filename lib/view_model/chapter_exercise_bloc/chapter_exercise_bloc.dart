import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chapter_exercise_model/chapter_ex_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'chapter_exercise_event.dart';
import 'chapter_exercise_states.dart';

class ChapterExerciseBloc extends Bloc<ChapterExScreenEvent, ChapterExerciseState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  ChapterExerciseBloc(super.initialState){
    on<ChapterExEvent>((event, emit) async{
      emit(ChapterExLoadingState());
      ChapterExGetModel response = await homeBookRepository.chapterExerciseApi(id: event.id);
      if(response.data != null && response.data!.isNotEmpty && response.data != []){
        emit(ChapterExLoadedState(response: response));
      }
      else{
        emit(ChapterExErrorState(error: 'Something went wrong'));
      }
    });
  }

}