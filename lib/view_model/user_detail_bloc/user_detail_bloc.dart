import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/view_model/user_detail_bloc/user_detail_event.dart';
import 'package:ilm_updated_version/view_model/user_detail_bloc/user_detail_state.dart';

import '../../models/user_detail_model/user_detail_model.dart';
import '../../repository/accounts_data_repo/accounts_data_repository.dart';

class UserDetailBloc extends Bloc<UserDetailScreenEvent,UserDetailState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();
  UserDetailBloc(super.initialState){
    on<UserDetailEvent>((event, emit) async{
      emit(UserDetailLoadingState());
      String response = await accountDataRepository.userDetail();
      if(response == 'success'){
        emit(UserDetailLoadedState(response: response));
      }
      else{
        emit(UserDetailErrorState(error: response));
      }
    });
  }
}