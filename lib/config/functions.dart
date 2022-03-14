import 'package:cyient_assignment/models/post/post.dart';
import 'package:cyient_assignment/models/user/user.dart';

List<Post> processData(List<Post> posts, List<User> user) {
  List<Post> result = posts
      .map((post) => Post.fromMap({
            'id': post.id,
            'userId': post.userId,
            'title': post.title,
            'body': post.body,
            'userName':
                user.where((user) => user.id == post.userId).first.username ??
                    ''
          }))
      .toList();
  return result;
}
