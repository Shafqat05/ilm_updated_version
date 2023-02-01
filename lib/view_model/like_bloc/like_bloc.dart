import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_repository/home_book_repository.dart';
import 'like_event.dart';
import 'like_state.dart';

class LikeDislikeBloc extends Bloc<LikeScreenEvent, LikeState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  LikeDislikeBloc(super.initialState){
    on<LikeEvent>((event, emit) async{
      emit(LikeLoadingState());
      String response = await homeBookRepository.likeDislike(
          solId: event.solId.toString(),
          chpId: event.chpId.toString(),
          bId: event.bId.toString(),
          exId: event.exId.toString(),
          likeDislike: event.likeDislike.toString());
      if(response == 'success'){
        emit(LikeLoadedState(response: response));
      }
      else{
        emit(LikeErrorState(error: response));
      }
    });
  }
}