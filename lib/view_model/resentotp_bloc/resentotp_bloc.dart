import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/view_model/resentotp_bloc/resentotp_event.dart';
import 'package:ilm_updated_version/view_model/resentotp_bloc/resentotp_state.dart';

import '../../repository/accounts_data_repo/accounts_data_repository.dart';

class ResentOtpBloc extends Bloc<ResentOtpScreenEvent, ResentOtpState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();

  ResentOtpBloc(super.initialState){
    on<ResentOtpEvent>((event, emit) async{
      emit(ResentOtpLoadingState());
      String response = await accountDataRepository.resentOtp(email: event.email);
      if(response == 'success'){
        emit(ResentOtpLoadedState(response: response));
      }
      else{
        emit(ResentOtpErrorState(error: response));
      }
    });
  }
}