abstract class SolInfoScreenEvent{}
class SolInfoEvent extends SolInfoScreenEvent{
  String exId;
  SolInfoEvent({required this.exId});
}