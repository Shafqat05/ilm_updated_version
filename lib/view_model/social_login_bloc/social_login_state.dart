import '../../models/social_login_model/social_login_model.dart';

abstract class SocialLoginState{}
class SocialLoginInitialState extends SocialLoginState{}
class SocialLoginLoadingState extends SocialLoginState{}
class SocialLoginLoadedState extends SocialLoginState{
  //SocialLoginModel response;
  String? response;
  SocialLoginLoadedState({this.response});
}
class SocialLoginErrorState extends SocialLoginState{
  String? error;
  SocialLoginErrorState({this.error});
}