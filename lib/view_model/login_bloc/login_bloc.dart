
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/repository/accounts_data_repo/accounts_data_repository.dart';

import 'login_events.dart';
import 'login_state.dart';


class LoginScreenBloc extends Bloc<LoginScreenEvents, LoginState>{
  AccountDataRepository accountsData = AccountDataRepository();
  String response = '';
  //BuildContext? context;
  LoginScreenBloc(super.initailState){
    on<LoginEvents>((event, emit) async{
      emit(LoginLoadingState());
      response  = await accountsData.login(event.email, event.password,);
      if(response == 'success'){
        emit(LoginLoadedState(response: response));
      }
      else{
        emit(LoginErrorState(error: response));
      }
    });
  }
}