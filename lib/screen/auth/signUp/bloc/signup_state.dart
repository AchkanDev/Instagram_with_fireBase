part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupLoading extends SignupState {}

class SignupInitial extends SignupState {}

class SignupSuccess extends SignupState {
  final String result;

  SignupSuccess(this.result);
}

class SignupError extends SignupState {
  final AppException appExeption;

  SignupError(this.appExeption);
}
