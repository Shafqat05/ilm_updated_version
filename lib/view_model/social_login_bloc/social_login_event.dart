abstract class SocialLoginScreenEvent{}
class SocialLoginEvent extends SocialLoginScreenEvent{
  String? email;
  String? socialType;
  String? socialId;
  String? fName;
  String? lName;
  SocialLoginEvent({this.lName,this.fName,this.socialId,this.socialType,this.email});
}