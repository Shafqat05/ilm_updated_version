import '../../models/comment_list_model/comment_list_model.dart';
import 'comment_list_bloc.dart';

abstract class CommentListState{}
class CommentListInitialState extends CommentListState{

}
class CommentListLoadingState extends CommentListState{}
class CommentListLoadedState extends CommentListState{
  CommentListModel response;
  CommentListLoadedState({required this.response});
}
class CommentListErrorState extends CommentListState{
  String error;
  CommentListErrorState({required this.error});
}