abstract class LoginScreenEvents{
  const LoginScreenEvents();
}

class LoginEvents extends LoginScreenEvents{
  String email;
  String password;
  LoginEvents({required this.email, required this.password});
}