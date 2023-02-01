import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_repository/home_book_repository.dart';
import 'delete_comment_event.dart';
import 'delete_comment_state.dart';

class DeleteCommentBloc
    extends Bloc<DelCommentScreenEvent, DeleteCommentState> {
  HomeBookRepository homeBookRepository = HomeBookRepository();
  DeleteCommentBloc(super.initialState) {
    on<DeleteCommentEvent>((event, emit) async {
      emit(DelCommentLoadingState());
      String response =
          await homeBookRepository.deleteCommentApi(cId: event.cId);
      if (response == 'success') {
        emit(DelCommentLoadedState(response: response));
      } else {
        emit(DelCommentErrorState(error: response));
      }
    });
  }
}
