import '../../models/my_subscription_model/my_subscription_model.dart';

abstract class MySubscriptionState{}
class MySubsInitialState extends MySubscriptionState{}
class MySubsLoadingState extends MySubscriptionState{}
class MySubsLoadedState extends MySubscriptionState{
  MySubscriptionModel response;
  MySubsLoadedState({required this.response});
}
class MySubsErrorState extends MySubscriptionState{
  String error;
  MySubsErrorState({required this.error});
}