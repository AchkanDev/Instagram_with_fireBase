import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/utils/appExeption.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository authRepository;
  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is ClickToLogin) {
        try {
          emit(LoginLoading());
          final result =
              await authRepository.logIn(event.username, event.password);
          emit(LoginSuccess(result));
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(LoginError(AppException(messageError: e.message!)));
          } else {
            emit(LoginError(AppException(messageError: e.toString())));
          }
        }
      }
    });
  }
}
