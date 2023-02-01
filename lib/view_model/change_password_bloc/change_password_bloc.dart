import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/accounts_data_repo/accounts_data_repository.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordScreenEvent, ChangePasswordState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();

  ChangePasswordBloc(super.initialState){
    on<ChangePasswordEvent>((event, emit) async{
      emit(ChangePassLoadingState());
      String response = await accountDataRepository.changePassword(oldPassword: event.oldPassword, conformpassword: event.conformPassword);
      if(response == 'success'){
        emit(ChangePassLoadedState(response: response));
      }
      else{
        emit(ChangePassErrorState(error: response));
      }
    });
  }

}