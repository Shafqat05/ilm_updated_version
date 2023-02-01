import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/view_model/package_list_bloc/package_list_event.dart';
import 'package:ilm_updated_version/view_model/package_list_bloc/package_list_state.dart';

import '../../models/package_list_model/package_list_model.dart';
import '../../repository/home_repository/home_book_repository.dart';

class PackageListBloc extends Bloc<PackageListScreenEvent,PackageListState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();
  PackageListBloc(super.initialState){
    on<PackageListEvent>((event, emit) async{
      emit(PackageListLoadingState());
      PackageListModel response = await homeBookRepository.packageListApi();
      if(response != null && response != []){
        emit(PackageListLoadedState(response: response));
      }
      else{
        emit(PackageListErrorState(error: 'Some error occour'));
      }
    });
  }
}