import 'package:cyient_assignment/models/post/post.dart';
import 'package:cyient_assignment/ui/post/create_post/create_post.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePostWidget(post: _data[_index]),
                          fullscreenDialog: true),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit")),
              Row(
                children: [
                  const Text("User Name: ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(_data[_index].id!.toString(),
                      style: const TextStyle(fontSize: 15)),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(_data[_index].title!, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
