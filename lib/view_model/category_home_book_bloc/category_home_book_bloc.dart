
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/category_book_model/category_book_get_model.dart';
import '../../models/searchbook_get_model/searchbook_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'category_home_book_event.dart';
import 'category_home_book_states.dart';


class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState>{
  HomeBookRepository homeScreenRepository = HomeBookRepository();
  // String response = '';

  HomeScreenBloc(super.initialState){
    on<HomeEvent>((event, emit) async{
      emit(HomeScreenLoadingState());
      CategoryBookGetModel response = await homeScreenRepository.bookByCategoryApi();
      // SearchBookGetModel response1 = await homeScreenRepository.searchBookApi(
      //     isbn: event.isbn,
      //     bookName: event.bookName,
      //     bookAuthor: event.bookAuthor,
      //     searchKeword: event.searchkeyword);
      if(response != null && response !=[]  ){
        emit(HomeScreenLoadedState(response: response,));
      }
      else{
        emit(HomeScreenErrorState(error: 'Something went wrong'));
      }
    });
  }
}