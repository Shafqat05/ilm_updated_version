import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/my_subscription_model/my_subscription_model.dart';
import '../../repository/home_repository/home_book_repository.dart';
import 'my_subscription_event.dart';
import 'my_subscription_state.dart';

class MySubscriptionBloc extends Bloc<MySubscScreenEvent,MySubscriptionState>{
  HomeBookRepository homeBookRepository = HomeBookRepository();

  MySubscriptionBloc(super.initialState){
    on<MySubscriptionEvent>((event, emit) async{
      emit(MySubsLoadingState());
      MySubscriptionModel response = await homeBookRepository.mySubscriptionApi();
      if(response.data != null && response.data != []){
        emit(MySubsLoadedState(response: response));
      }
      else{
        emit(MySubsErrorState(error: 'Some error '));
      }
    });
  }
}