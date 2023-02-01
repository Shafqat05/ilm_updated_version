import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/bookmark_list_model/bookmark_list_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'bookmark_list_event.dart';
import 'bookmark_list_state.dart';

class BookMarkListBloc extends Bloc<BookMarkListScreenEvent,BookMarkListState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  BookMarkListBloc(super.initialState){
    on<BookMarkListEvent>((event, emit) async{
      emit(BookMarkListLoadingState());
      BookMarkListGetModel response = await homeBookRepository.bookMarkListApi(bookMarkId: event.bookMarkId);
      if(response.data != null && response.data != []){
        emit(BookMarkListLoadedState(response: response));
      }
      else{
        emit(BookMarkListErrorState(error: 'Some error occour'));
      }
    });

  }
}