import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/home_repository/home_book_repository.dart';
import 'check_subs_event.dart';
import 'check_subs_state.dart';

class CheckSubscriptionBloc extends Bloc<CheckSubsScreenEvent, CheckSubsState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  CheckSubscriptionBloc(super.initialState){
    on<CheckSubsEvent>((event, emit) async{
      emit(CheckSubsLoadingState());
      String response = await homeBookRepository.checkSubscription(pkgId: event.pkgId);
      if(response == 'success'){
        emit(CheckSubsLoadedState(response: response));
      }
      else{
        emit(CheckSubsErrorState(error: response));
      }
    });
  }

}