import '../../models/package_list_model/package_list_model.dart';

abstract class PackageListState{}
class PackageListInitialState extends PackageListState{}
class PackageListLoadingState extends PackageListState{}
class PackageListLoadedState extends PackageListState{
  PackageListModel response;
  PackageListLoadedState({required this.response});
}
class PackageListErrorState extends PackageListState{
  String error;
  PackageListErrorState({required this.error});
}