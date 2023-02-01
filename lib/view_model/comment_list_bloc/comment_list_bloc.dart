import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/comment_list_model/comment_list_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'comment_list_event.dart';
import 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListScreenEvent,CommentListState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  CommentListBloc(super.initialState){
    on<CommentListEvent>((event, emit) async{
      emit(CommentListLoadingState());
      CommentListModel response = await homeBookRepository.commentListApi(solId: event.solId,exId: event.exId);
      if(response.data != null && response.data != []){
        emit(CommentListLoadedState(response: response));
      }
      else{
        emit(CommentListErrorState(error: 'Some error'));
      }
    });
  }
}