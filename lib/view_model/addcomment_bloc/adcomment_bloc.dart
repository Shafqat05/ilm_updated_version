import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_repository/home_book_repository.dart';
import 'addcomment_event.dart';
import 'addcomment_state.dart';

class AddCommentBloc extends Bloc<AddCommentScreenEvent,AddCommentState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  BuildContext? context;
  AddCommentBloc(super.initialState){
    on<AddCommentEvent>((event, emit) async{
      emit(AddCommentLoadingState());
      String response = await homeBookRepository.addComment(
          exId: event.exId,
          bId: event.bId,
          chpId: event.chpId,
          comment: event.comment,
          solId: event.solId);
      if(response == 'success'){
        emit(AddCommentLoadedState(response: response));
      }
      else{
        emit(AddCommentErrorState(error: response));
      }
    });
  }
}