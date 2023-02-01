import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_repository/home_book_repository.dart';
import 'edit_comment_event.dart';
import 'edit_comment_state.dart';

class EditCommentBloc extends Bloc<EditCommentScreenEvent,EditCommentState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  EditCommentBloc(super.initialState){
    on<EditCommentEvent>((event, emit) async{
      emit(EditCommentLoadingState());
      String response = await homeBookRepository.editComment(solId: event.solId,chpId: event.chpId,comment: event.comment);
      if(response == 'success'){
        emit(EditCommentLoadedState(response: response));
      }
      else{
        emit(EditCommentErrorState(error: response));
      }
    });
  }

}