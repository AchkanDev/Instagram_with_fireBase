import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/models/signup.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/utils/appExeption.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final IAuthRepository authRepository;
  SignupBloc(this.authRepository) : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      try {
        if (event is ClickToSignUp) {
          emit(SignupLoading());

          final result = await authRepository.signUp(event.user);
          emit(SignupSuccess(result));
        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          // if (e.code == "invalid-email") {
          //   emit(SignupError(
          //       AppException(messageError: "The email is badly formatted")));
          // } else if (e.code == "weak-password") {
          //   emit(SignupError(AppException(
          //       messageError: "Password should be at least 6 characters")));
          // } else if (e.code == "email-already-in-use") {
          //   emit(SignupError(AppException(
          //       messageError: "The email address is already in use by another account.")));
          // } else {
          //   emit(SignupError(AppException(
          //       messageError: "Unknown error, check your internet")));
          // }
          emit(SignupError(AppException(messageError: e.message!)));
        } else {
          emit(SignupError(AppException(messageError: e.toString())));
        }
      }
    });
  }
}
