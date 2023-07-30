import 'package:flutter/cupertino.dart';
import 'package:instagram/data/auth/dataSource/auth_dataSource.dart';
import 'package:instagram/models/signup.dart';
import 'package:instagram/models/user.dart';

final authRepository = AuthRepository(AuthRemoteDataSource());

abstract class IAuthRepository {
  Future<String> signUp(SignUpEntity userEntity);
  Future<String> logIn(String username, String password);
  Future<UserEntity> getDetails();
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  static ValueNotifier<UserEntity> getDetailsValueNotifier =
      ValueNotifier(UserEntity("", "", "", "", "", "", [], []));
  final IAuthDataSource authDataSource;

  AuthRepository(this.authDataSource);
  @override
  Future<String> signUp(SignUpEntity userEntity) {
    return authDataSource.signUp(userEntity);
  }

  @override
  Future<String> logIn(String username, String password) {
    return authDataSource.logIn(username, password);
  }

  @override
  Future<UserEntity> getDetails() async {
    UserEntity user = await authDataSource.getDetails();
    getDetailsValueNotifier.value = user;
    return user;
  }

  @override
  Future<void> signOut() async {
    getDetailsValueNotifier.value = UserEntity("", "", "", "", "", "", [], []);
    await authDataSource.signOut();
  }
}
