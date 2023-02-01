import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ilm_updated_version/view_model/signup_bloc/signup_event.dart';
import 'package:ilm_updated_version/view_model/signup_bloc/signup_states.dart';
import 'package:ilm_updated_version/repository/accounts_data_repo/accounts_data_repository.dart';

class SignUpBloc extends Bloc<SignUpScreenEvent, SignupState>{
  AccountDataRepository accountDataRepository = AccountDataRepository();
  String response = '';

  SignUpBloc(super.initialState){
   on<SignUpEvent>((event, emit) async{
     emit(SignupLoadingState());
     response = await accountDataRepository.signUpApi(fName: event.fName, lName: event.lName, email: event.email, password: event.password, phoneNumber: event.phoneNumber);
     if(response == 'success'){
       emit(SignupLoadedState(response: response));
     }
     else{
       emit(SignupErrorState(error: response));
     }
   });
  }
}