class User {
  int? id;
  String? name;
  String? username;
  String? email;

  User({
    this.name,
    this.id,
    this.username,
    this.email,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
        "username": username,
        "email": email,
      };
}
