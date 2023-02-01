abstract class BookSubscriptionState{}
class BookSubsInitialState extends BookSubscriptionState{}
class BookSubsLoadingState extends BookSubscriptionState{}
class BookSubsLoadedState extends BookSubscriptionState{
  String response;
  BookSubsLoadedState({required this.response});
}
class BookSubsErrorState extends BookSubscriptionState{
  dynamic error;
  BookSubsErrorState({required this.error});
}