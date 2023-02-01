import 'package:ilm_updated_version/models/bookByCatId_get_model/bookByCatId_get_model.dart';

abstract class BookByCatIdState{}
class BookByCatIdInitialState extends BookByCatIdState{}
class BookByCatIdLoadingState extends BookByCatIdState{}
class BookByCatIdLoadedState extends BookByCatIdState{
  BookByCatIdGetModel response;

  BookByCatIdLoadedState({required this.response,});
}
class BookByCatIdErrorState extends BookByCatIdState{
  String error;
  BookByCatIdErrorState({required this.error});
}