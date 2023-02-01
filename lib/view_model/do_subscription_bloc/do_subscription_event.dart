abstract class DoSubscScreenEvent{}
class DoSubscriptionEvent extends DoSubscScreenEvent{
  String? pkgId;
  String? tId;
  String? amount;
  String? coupon;
  String? recurring;
  DoSubscriptionEvent({this.recurring,this.coupon,this.amount,this.tId,this.pkgId});
}