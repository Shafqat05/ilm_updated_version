import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/accounts_data_repo/accounts_data_repository.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpScreenEvent,OtpState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();

  OtpBloc(super.initialState){
    on<OtpEvent>((event, emit) async{
      emit(OtpLoadingState());
      String response = await accountDataRepository.otpVerification(email: event.email,otpCode: event.otpCode);
      if(response == 'success'){
        emit(OtpLoadedState(response: response));
      }
      else{
        emit(OtpErrorState(error: response));
      }
    });
  }

}