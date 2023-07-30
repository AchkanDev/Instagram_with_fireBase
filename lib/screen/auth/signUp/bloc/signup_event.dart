part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class ClickToSignUp extends SignupEvent {
  final SignUpEntity user;

  ClickToSignUp(this.user);
}
