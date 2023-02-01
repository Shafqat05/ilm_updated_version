import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/bookByCatId_get_model/bookByCatId_get_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'package:ilm_updated_version/view_model/bookbycatid_bloc/bookbycatid_event.dart';
import 'package:ilm_updated_version/view_model/bookbycatid_bloc/bookbycatid_states.dart';

class BookByCatIdBloc extends Bloc<BookByCatIdScreenEvent, BookByCatIdState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  BookByCatIdBloc(super.initialState){
    on<BookByCatIdEvent>((event, emit) async{
      emit(BookByCatIdLoadingState());
      print('object ..${event.CartId}');
      BookByCatIdGetModel  response = await homeBookRepository.bookByCatidApi(CartId: event.CartId);
      print('objectsss ..${response}');

      if(response.data != null && response.data!.isNotEmpty && response.data != []){
        emit(BookByCatIdLoadedState(response: response));
      }
      else{
        emit(BookByCatIdErrorState(error: 'Something went wrong'));
      }
    });
  }
}