part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class AddPostButtonClicked extends AddPostEvent {
  final PostRequest postRequest;
  final Uint8List file;

  AddPostButtonClicked(this.postRequest, this.file);
}

class AddPostSrarted extends AddPostEvent {}
