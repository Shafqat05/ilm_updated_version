import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/view_model/social_login_bloc/social_login_event.dart';
import 'package:ilm_updated_version/view_model/social_login_bloc/social_login_state.dart';

import '../../repository/accounts_data_repo/accounts_data_repository.dart';

class SocialLoginBloc extends Bloc<SocialLoginScreenEvent, SocialLoginState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();
  SocialLoginBloc(super.initialState){
    on<SocialLoginEvent>((event, emit) async{
      emit(SocialLoginLoadingState());
      String response = await accountDataRepository.socialLoginApi(
        email: event.email,
        lName: event.lName,
        fName: event.fName,
        socialId: event.socialId,
        socialType: event.socialType
      );
      if(response == 'success'){
        emit(SocialLoginLoadedState(response: response));
      }
      else{
        emit(SocialLoginErrorState(error: response));
      }
    });
  }
}