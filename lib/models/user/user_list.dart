import './user.dart';

class UserList {
  final List<User>? user;

  UserList({
    this.user,
  });

  factory UserList.fromJson(List<dynamic> json) {
    List<User> user = <User>[];
    user = json.map((user) => User.fromMap(user)).toList();

    return UserList(
      user: user,
    );
  }
}
