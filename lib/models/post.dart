class PostEntity {
  final String userName;
  final String uid;
  final String description;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  PostEntity(this.userName, this.uid, this.description, this.postId,
      this.datePublished, this.postUrl, this.profImage, this.likes);

  PostEntity.fromJson(Map<String, dynamic> json)
      : userName = json["username"],
        uid = json["uid"],
        description = json["description"],
        postId = json["postId"],
        datePublished = json["datePublished"],
        profImage = json["profImage"],
        likes = json["likes"],
        postUrl = json["postUrl"];
  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "description": description,
        "postId": postId,
        "datePublished": datePublished,
        "profImage": profImage,
        "likes": likes,
        "postUrl": postUrl
      };
}

class PostRequest {
  final String userName;
  final String uid;
  final String description;

  final String profImage;

  PostRequest(this.userName, this.uid, this.description, this.profImage);
}
