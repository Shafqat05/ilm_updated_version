import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/view_model/sol_info_bloc/sol_info_event.dart';
import 'package:ilm_updated_version/view_model/sol_info_bloc/sol_info_state.dart';

import '../../models/sol_info_model/sol_info_model.dart';
import '../../repository/home_repository/home_book_repository.dart';

class SolInfoBloc extends Bloc<SolInfoScreenEvent, SolInfoState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  SolInfoBloc(super.initialState){
    on<SolInfoEvent>((event, emit) async{
      emit(SolInfoLoadingState());
      SolInfoGetModel response = await homeBookRepository.solInfoApi(exId: event.exId);
      if(response != null ){
        emit(SolInfoLoadedState(response: response));
      }
      else{
        emit(SolInfoErrorState(error: 'Some error'));
      }
    });
  }
}