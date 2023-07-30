part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String success;

  LoginSuccess(this.success);
}

class LoginError extends LoginState {
  final AppException appException;

  LoginError(this.appException);
}
