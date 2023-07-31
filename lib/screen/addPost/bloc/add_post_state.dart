part of 'add_post_bloc.dart';

@immutable
abstract class AddPostState {
  final UserEntity? user;

  const AddPostState({this.user});
}

class AddPostInitial extends AddPostState {
  const AddPostInitial({super.user});
}

class AddPostLoading extends AddPostState {
  const AddPostLoading({super.user});
}

class LoadingAddingPost extends AddPostState {
  const LoadingAddingPost({super.user});
}

class AddPostSuccess extends AddPostState {
  final String messageSuccess;

  const AddPostSuccess(this.messageSuccess, {super.user});
}

class AddPostError extends AddPostState {
  final AppException appException;

  const AddPostError(this.appException, {super.user});
}
