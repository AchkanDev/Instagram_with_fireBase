import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/models/post.dart';
import 'package:instagram/services/storage_firebase.dart';
import 'package:instagram/utils/appExeption.dart';
import 'package:uuid/uuid.dart';

abstract class IPostDataSource {
  Future<String> addPost(PostRequest postRequest, Uint8List imagePost);
  Future<List<PostEntity>> getPosts();
  Future<PostEntity> getPost(String postId);
  Future<PostEntity> update();
}

class PostRemoteDataSource implements IPostDataSource {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  @override
  Future<String> addPost(PostRequest postRequest, Uint8List imagePost) async {
    try {
      String imgUrl = await StorageMethods()
          .uploadImageToStorage("postPic", imagePost, true);
      final postId = Uuid().v1();

      PostEntity post = PostEntity(
          postRequest.userName,
          postRequest.uid,
          postRequest.description,
          postId,
          DateTime.now(),
          imgUrl,
          postRequest.profImage, []);

      await fireStore.collection("posts").doc(postId).set(post.toJson());
      return "Posted !";
    } catch (e) {
      throw AppException(messageError: e.toString());
    }
  }

  @override
  Future<List<PostEntity>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<PostEntity> getPost(String postId) {
    // TODO: implement getPost
    throw UnimplementedError();
  }

  @override
  Future<List<PostEntity>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<PostEntity> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
