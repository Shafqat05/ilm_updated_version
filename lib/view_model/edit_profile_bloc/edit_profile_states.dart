abstract class EditProfileState{}
class EditProfileInitialState extends EditProfileState{

}
class EditProfileLoadingState extends EditProfileState{}
class EditProfileLoadedState extends EditProfileState{
  String response;
  EditProfileLoadedState({required this.response});

}
class EditProfileErrorState extends EditProfileState{
  String error;
  EditProfileErrorState({required this.error});
}