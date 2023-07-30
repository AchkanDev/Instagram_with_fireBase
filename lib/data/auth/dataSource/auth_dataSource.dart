import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/models/signup.dart';
import 'package:instagram/models/user.dart' as model;
import 'package:instagram/models/user.dart';
import 'package:instagram/services/storage_firebase.dart';

abstract class IAuthDataSource {
  Future<String> signUp(SignUpEntity userEntity);
  Future<String> logIn(String username, String password);
  Future<UserEntity> getDetails();
  Future<void> signOut();
}

class AuthRemoteDataSource implements IAuthDataSource {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  @override
  Future<String> signUp(SignUpEntity singupEntity) async {
    String res = "has error";
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: singupEntity.email, password: singupEntity.password);
    String imgUrl = await StorageMethods()
        .uploadImageToStorage("profilePic", singupEntity.file, false);
    model.UserEntity user = model.UserEntity(
        singupEntity.userName,
        userCredential.user!.uid,
        singupEntity.password,
        singupEntity.email,
        singupEntity.bio,
        imgUrl, [], []);

    await fireStore
        .collection("users")
        .doc(userCredential.user!.uid)
        .set(user.toJson());

    await logIn(singupEntity.email, singupEntity.password);

    res = "${singupEntity.userName} entered successfully";

    return res;
  }

  @override
  Future<String> logIn(String username, String password) async {
    String res = "has error";
    await auth.signInWithEmailAndPassword(email: username, password: password);
    res = "$username entered successfully";
    return res;
  }

  @override
  Future<model.UserEntity> getDetails() async {
    final user = auth.currentUser?.uid;
    DocumentSnapshot snapshot =
        await fireStore.collection("users").doc(user).get();

    UserEntity userEntity =
        UserEntity.fromJson(snapshot.data() as Map<String, dynamic>);

    return userEntity;
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
