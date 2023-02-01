import '../../models/chapter_info/chapter_info_get_model.dart';

abstract class ChapterInfoState{}
class ChpInfoInitialState extends ChapterInfoState{}
class ChpInfoLoadingState extends ChapterInfoState{}
class ChpInfoLoadedState extends ChapterInfoState{
  ChapterInfoGetModel response;
  ChpInfoLoadedState({required this.response});
}
class ChpInfoErrorState extends ChapterInfoState{
  String error;
  ChpInfoErrorState({required this.error});
}