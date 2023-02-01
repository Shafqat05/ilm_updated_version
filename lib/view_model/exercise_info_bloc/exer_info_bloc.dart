import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/exercise_info_model/exercise_info_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'exer_info_event.dart';
import 'exer_info_state.dart';

class ExerciseInfoBloc extends Bloc<ExerInfoScreenEvent,ExerciseInfoState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  ExerciseInfoBloc(super.initialState){
    on<ExerInfoEvent>((event, emit) async{
      emit(ExerInfLoadingState());
      ExerciseInfoGetModel response = await homeBookRepository.exerciseInfoApi(exId: event.exId,bookId: event.bookId,chpId: event.chpId);
      if(response != null ){
        emit(ExerInfoLoadedState(response: response));
      }
      else{
        emit(ExerInfoErrorState(error: 'Some error occour'));
      }
    });
  }
}