import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chapter_info/chapter_info_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'chapter_info_event.dart';
import 'chapter_info_state.dart';

class ChapterInfoBloc extends Bloc<ChapterInfoScreenEvent, ChapterInfoState>{

  HomeBookRepository homeBookRepository = HomeBookRepository();

  ChapterInfoBloc(super.initialState){
    on<ChapterInfoEvent>((event, emit) async{
      emit(ChpInfoLoadingState());
      ChapterInfoGetModel response = await homeBookRepository.chapterInfoApi(id: event.id,chpNu: event.chpNum);
      if(response != null ){
        emit(ChpInfoLoadedState(response: response));
      }
      else{
        emit(ChpInfoErrorState(error: 'Something went wrong'));
      }
    });
  }
}