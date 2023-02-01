import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/accounts_data_repo/accounts_data_repository.dart';
import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutScreenEvent, LogoutState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();


  LogoutBloc(super.initialState){
    on<LogoutEvent>((event, emit) async{
      emit(LogoutLoadingState());
     String response = await accountDataRepository.logout();
      if(response == 'success'){
        emit(LogoutLoadedState(response: response));
      }
      else{
        emit(LogoutErrorState(error: response));
      }
    });
  }
}