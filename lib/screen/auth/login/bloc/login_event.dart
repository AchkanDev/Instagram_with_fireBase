part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class ClickToLogin extends LoginEvent {
  final String username;
  final String password;

  ClickToLogin(this.username, this.password);
}
