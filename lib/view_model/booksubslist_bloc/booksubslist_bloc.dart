import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/booksubslist_get_model/booksubslist_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'booksubslist_event.dart';
import 'booksubslist_state.dart';

class BookSubsListBloc extends Bloc<BookSubsListScreenEvent, BookSubsListState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  BookSubsListBloc(super.initialState){
    on<BookSubsListEvent>((event, emit) async{
      emit(BookSubsListLoadingState());
      BookSubsListGetModel response = await homeBookRepository.bookSubsListApi(subBookid: event.subsBookId);
      if(response.data != null && response.data != []){
        emit(BookSubsListLoadedState(response: response));
      }
      else{
        emit(BookSubsListErrorState(error: 'Some error occour'));
      }
    });
  }
}