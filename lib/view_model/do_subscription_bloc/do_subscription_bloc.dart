import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/do_subscription_model/do_subscription_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'do_subscription_event.dart';
import 'do_subscription_state.dart';

class DoSubscriptionBloc extends Bloc<DoSubscScreenEvent,DoSubscriptionState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  DoSubscriptionBloc(super.initialState){
    on<DoSubscriptionEvent>((event, emit) async{
      emit(DoSubsLoadingState());
      DoSubscriptionModel response = await homeBookRepository.doSubscriptionApi(
        amount: event.amount,
        coupon: event.coupon,
        pkgId: event.pkgId,
        recurring: event.recurring,
        tId: event.tId
      );
      if(response.data != null && response.data != []){
        emit(DoSubsLoadedState(response: response));
      }
      else{
        emit(DoSubsErrorState(error: 'Some error '));
      }
    });
  }
}