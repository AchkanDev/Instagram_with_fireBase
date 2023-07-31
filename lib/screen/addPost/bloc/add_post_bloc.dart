import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:instagram/data/auth/dataSource/auth_dataSource.dart';
import 'package:instagram/data/auth/repository/auth_repository.dart';
import 'package:instagram/data/auth/repository/post_repository.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/models/user.dart';
import 'package:instagram/utils/appExeption.dart';
import 'package:meta/meta.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final IPostRepository postRepository;
  final IAuthRepository authRepository;

  AddPostBloc(this.postRepository, this.authRepository)
      : super(const AddPostLoading()) {
    on<AddPostEvent>((event, emit) async {
      final user = await authRepository.getDetails();
      if (event is AddPostButtonClicked) {
        try {
          final res =
              await postRepository.addPost(event.postRequest, event.file);
          // emit(LoadingAddingPost());

          emit(AddPostSuccess(res, user: user));
        } catch (e) {
          emit(AddPostError(AppException(messageError: e.toString())));
        }
      } else if (event is AddPostSrarted) {
        emit(AddPostInitial(user: user));

        // TODO: implement event handler
      }
    });
  }
}
