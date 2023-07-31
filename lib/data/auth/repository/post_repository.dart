import 'package:flutter/foundation.dart';
import 'package:instagram/data/auth/dataSource/post_dataSource.dart';
import 'package:instagram/models/post.dart';

final postRepository = PostRepository(PostRemoteDataSource());

abstract class IPostRepository {
  Future<String> addPost(PostRequest postRequest, Uint8List postFile);
  Future<List<PostEntity>> getPosts();
  Future<PostEntity> getPost(String postId);
  Future<PostEntity> update();
}

class PostRepository implements IPostRepository {
  final IPostDataSource postDataSource;

  PostRepository(this.postDataSource);
  @override
  Future<String> addPost(PostRequest postRequest, Uint8List postFile) {
    return postDataSource.addPost(postRequest, postFile);
  }

  @override
  Future<PostEntity> getPost(String postId) {
    return postDataSource.getPost(postId);
  }

  @override
  Future<List<PostEntity>> getPosts() {
    return postDataSource.getPosts();
  }

  @override
  Future<PostEntity> update() {
    return postDataSource.update();
  }
}
