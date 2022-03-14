class Post {
  int? userId;
  int? id;
  String? title;
  String? body;
  String? userName;

  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.userName,
  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userName: json["userName"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
        "userName": userName,
      };
  
}
