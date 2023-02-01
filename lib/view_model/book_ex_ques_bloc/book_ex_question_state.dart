import '../../models/book_ex_question_get_model/book_ex_question_get_model.dart';

abstract class BookExQuestionState{}
class BookExQuesInitialState extends BookExQuestionState{}
class BookExQuesLoadingState extends BookExQuestionState{}
class BookExQuesLoadedState extends BookExQuestionState{
  BookExQuesGetModel response;
  BookExQuesLoadedState({required this.response});

}
class BookExQuesErrorState extends BookExQuestionState{
  String error;
  BookExQuesErrorState({required this.error});
}