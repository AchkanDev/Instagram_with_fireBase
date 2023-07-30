import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/utils/appExeption.dart';
import 'package:meta/meta.dart';

part 'responsive_layout_event.dart';
part 'responsive_layout_state.dart';

class ResponsiveLayoutBloc
    extends Bloc<ResponsiveLayoutEvent, ResponsiveLayoutState> {
  final AuthRepository authRepository;
  ResponsiveLayoutBloc(this.authRepository) : super(ResponsiveLayoutInitial()) {
    on<ResponsiveLayoutEvent>((event, emit) async {
      try {
        if (event is ResponsiveLayoutStarted) {
          emit(ResponsiveLayoutLoading());
          final user = await authRepository.getDetails();
          emit(ResponsiveLayoutSuccess(user));
        }
      } catch (e) {
        if (e is FirebaseException) {
          emit(ResponsiveLayoutError(AppException(messageError: e.message!)));
        } else {
          emit(ResponsiveLayoutError(AppException(messageError: e.toString())));
        }
      }
    });
  }
}
