import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/view_model/searchbook_bloc/searchbook_event.dart';
import 'package:ilm_updated_version/view_model/searchbook_bloc/searchbook_state.dart';

import '../../models/category_book_model/category_book_get_model.dart';
import '../../models/searchbook_get_model/searchbook_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';

class SearchBookBloc extends Bloc<SearchBookScreenEvent, SearchBookState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  SearchBookBloc(super.initialState){
    on<SearchBookEvent>((event, emit) async{
      emit(SearchBookLoadingState());
      SearchBookGetModel response = await homeBookRepository.searchBookApi(
          isbn: event.isbn,
          bookName: event.bookName,
          bookAuthor: event.bookAuthor,
          searchKeword: event.searchkeyword);

      if(response != null && response != [] ){
        emit(SearchBookLoadedState(response: response,));
      }
      else{
        emit(SearchBookErrorState(error: 'Some error occour'));
      }
    });
  }
}