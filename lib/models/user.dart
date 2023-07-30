import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserEntity {
  final String userName;
  final String uid;
  final String password;
  final String email;
  final String bio;
  final String pohtoUrl;
  final List following;
  final List followers;

  UserEntity(this.userName, this.uid, this.password, this.email, this.bio,
      this.pohtoUrl, this.following, this.followers);

  UserEntity.fromJson(Map<String, dynamic> json)
      : userName = json["username"],
        uid = json["uid"],
        password = json["password"],
        email = json["email"],
        bio = json["bio"],
        following = json["following"],
        followers = json["followers"],
        pohtoUrl = json["photourl"];
  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "password": password,
        "email": email,
        "bio": bio,
        "following": following,
        "followers": followers,
        "photourl": pohtoUrl
      };
}
