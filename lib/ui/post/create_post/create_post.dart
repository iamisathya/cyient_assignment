import 'package:cyient_assignment/data/enum.dart';
import 'package:cyient_assignment/models/post/post.dart';
import 'package:cyient_assignment/stores/post/post_store.dart';
import 'package:cyient_assignment/ui/users/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatelessWidget {
  final Post? _post;
  const CreatePostWidget({Key? key, required Post? post})
      : _post = post,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(_post != null ? "Update Post" : "Create Post")),
        body: SafeArea(child: _createPostWidget()));
  }

  Widget _createPostWidget() {
    return ChangeNotifierProvider(
      create: (context) => PostController(),
      child: Consumer<PostController>(builder:
          (BuildContext context, PostController controller, Widget? _) {
        switch (controller.userState) {
          case UserState.UNINITIALISED:
            Future(() {
              controller.fetchUsers();
            });
            return const Center(child: CircularProgressIndicator());
          case UserState.FETCHING:
            return const Center(child: CircularProgressIndicator());
          case UserState.FETCHED:
            if (_post != null) {
              controller.fillCreatePostField(_post!);
            }
            return _scrollNotificationWidget(controller, context);
          case UserState.ERROR:
            return const Center(child: Text("Error!"));
        }
      }),
    );
  }

  Widget _scrollNotificationWidget(
      PostController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          UserListWidget(),
          const SizedBox(height: 20),
          TextField(
            key: const Key("title_field_key"),
              controller: controller.titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Title"),
                  hintText: "Enter title")),
          const SizedBox(height: 20),
          TextField(
            key: const Key("body_field_key"),
            controller: controller.bodyController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Body"),
                hintText: "Enter bosy"),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(height: 20),
          (controller.createPostState == CreatePostState.CREATING ||
                  controller.updatePostState == UpdatePostState.UPDATING)
              ? const CircularProgressIndicator()
              : ElevatedButton(
                key: const Key("create_button_key"),
                  onPressed: () => {
                        if (_post == null) // create
                          {
                            Provider.of<PostController>(context, listen: false)
                                .createPost(context)
                          }
                        else // update
                          {
                            Provider.of<PostController>(context, listen: false)
                                .updatePost(context, _post!.id!)
                          }
                      },
                  child: Text(_post != null ? "Update now" : "Create now"))
        ],
      ),
    );
  }
}
