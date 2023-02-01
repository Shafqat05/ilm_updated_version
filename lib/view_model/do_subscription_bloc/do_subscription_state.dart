import '../../models/do_subscription_model/do_subscription_model.dart';

abstract class DoSubscriptionState{}
class DoSubsInitialState extends DoSubscriptionState{}
class DoSubsLoadingState extends DoSubscriptionState{}
class DoSubsLoadedState extends DoSubscriptionState{
  DoSubscriptionModel response;
  DoSubsLoadedState({required this.response});
}
class DoSubsErrorState extends DoSubscriptionState{
  String error;
  DoSubsErrorState({required this.error});
}