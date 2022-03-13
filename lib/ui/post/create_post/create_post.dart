import 'package:cyient_assignment/data/enum.dart';
import 'package:cyient_assignment/stores/post/post_store.dart';
import 'package:cyient_assignment/ui/users/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({Key? key}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Create Post")),
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
            return const CircularProgressIndicator();
          case UserState.FETCHING:
            return const CircularProgressIndicator();
          case UserState.FETCHED:
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
              controller: controller.titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Title"),
                  hintText: "Enter title")),
          const SizedBox(height: 20),
          TextField(
            controller: controller.bodyController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Body"),
                hintText: "Enter bosy"),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => {
                    Provider.of<PostController>(context, listen: false)
                        .createPost(context)
                  },
              child: const Text("Create now"))
        ],
      ),
    );
  }
}
