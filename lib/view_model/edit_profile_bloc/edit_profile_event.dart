abstract class EditProfileScreenEvent{}
class EditProfileEvent extends EditProfileScreenEvent{
  String? firstName;
  String? lastName;
  EditProfileEvent({ this.firstName,  this.lastName});
}