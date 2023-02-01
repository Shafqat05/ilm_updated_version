abstract class BookMarkState{}
class BookMarkInitialState extends BookMarkState{}
class BookMarkLoadingState extends BookMarkState{}
class BookMarkLoadedState extends BookMarkState{
  String response;
  BookMarkLoadedState({required this.response});
}
class BookMarkErrorState extends BookMarkState{
  String error;
  BookMarkErrorState({required this.error});
}