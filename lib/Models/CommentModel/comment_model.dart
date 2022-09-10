class CommentModel {
  String? comment;
  late String postId;
  late String commentOwner;
  late String dateTime;
  String? image;

  CommentModel(
      {required this.comment,
      required this.dateTime,
      required this.postId,
      required this.commentOwner,
      required this.image});

  CommentModel.fromJson(Map<String, dynamic> data) {
    comment = data["comment"];
    postId = data["postId"];
    commentOwner = data["commentOwner"];
    dateTime = data["dateTime"];
    image = data["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "comment": comment,
      "postId": postId,
      "commentOwner": commentOwner,
      "dateTime": dateTime,
      "image": image,
    };
  }
}
