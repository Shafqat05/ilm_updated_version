import '../../models/category_book_model/category_book_get_model.dart';
import '../../models/searchbook_get_model/searchbook_get_model.dart';

abstract class HomeScreenState{}
class HomeScreenInitialState extends HomeScreenState{}
class HomeScreenLoadingState extends HomeScreenState{}
class HomeScreenLoadedState extends HomeScreenState{
  CategoryBookGetModel response;
  //SearchBookGetModel response1;
  HomeScreenLoadedState({required this.response,
   // required this.response1
  });
}
class HomeScreenErrorState extends HomeScreenState{
  String error;
  HomeScreenErrorState({required this.error });
}