import 'dart:typed_data';

class SignUpEntity {
  final String userName;
  final String password;
  final String email;
  final String bio;
  final Uint8List file;

  SignUpEntity(this.userName, this.password, this.email, this.bio, this.file);
}
