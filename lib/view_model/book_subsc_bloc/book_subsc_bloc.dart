import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_repository/home_book_repository.dart';
import 'book_subsc_event.dart';
import 'book_subsc_state.dart';

class BookSubscriptionBloc extends Bloc<BookSubscScreenEvent, BookSubscriptionState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  //String response = '';
  BookSubscriptionBloc(super.initialState){
    on<BookSubscriptionEvent>((event, emit) async{
      emit(BookSubsLoadingState());
      emit(BookSubsLoadedState(response: ''));
    });
  }
}