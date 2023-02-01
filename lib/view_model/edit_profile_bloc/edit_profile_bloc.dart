import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/accounts_data_repo/accounts_data_repository.dart';
import 'edit_profile_event.dart';
import 'edit_profile_states.dart';

class EditProfileBloc extends Bloc<EditProfileScreenEvent, EditProfileState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();
  String response = '';
  EditProfileBloc(super.initialState){
    on<EditProfileEvent>((event, emit) async{
      emit(EditProfileLoadingState());
      response = await accountDataRepository.editProfileMethod(firstName: event.firstName, lastName: event.lastName);
      if(response == 'success'){
        emit(EditProfileLoadedState(response: response));
      }
      else{
        emit(EditProfileErrorState(error: response));
      }
    });
  }

}