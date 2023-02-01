import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/accounts_data_repo/accounts_data_repository.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPassScreenEvent, ForgotPasswordState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();

  ForgotPasswordBloc(super.initialState){
    on<ForgotPasswordEvent>((event, emit) async{
      emit(ForgotPassLoadingState());
      String response = await accountDataRepository.forgotPassword(email: event.email);
      if(response == 'success'){
        emit(ForgotPassLoadedState(response: response));
      }
      else{
        emit(ForgotPassErrorState(error: response));
      }
    });
  }
}