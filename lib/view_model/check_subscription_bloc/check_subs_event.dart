abstract class CheckSubsScreenEvent{}
class CheckSubsEvent extends CheckSubsScreenEvent{
  String? pkgId;
  CheckSubsEvent({this.pkgId});
}