import 'package:cyient_assignment/models/post/post.dart';
import 'package:cyient_assignment/stores/post/post_store.dart';
import 'package:cyient_assignment/ui/post/create_post/create_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required List<Post> data,
    required int index,
  })  : _data = data,
        _index = index,
        super(key: key);

  final List<Post> _data;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Text("User Name: ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(_data[_index].userName!.toString(),
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(_data[_index].title!,
                      style: const TextStyle(fontSize: 15))),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreatePostWidget(post: _data[_index]),
                              fullscreenDialog: true),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit")),
                  TextButton.icon(
                      onPressed: () {
                        Provider.of<PostController>(context, listen: false).deletePost(_index);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
