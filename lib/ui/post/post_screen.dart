import 'package:cyient_assignment/data/enum.dart';
import 'package:cyient_assignment/stores/post/post_store.dart';
import 'package:cyient_assignment/ui/post/create_post/create_post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'post_list.dart';

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Cyient Assignment"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => PostController(),
        child: Consumer<PostController>(
          builder:
              (BuildContext context, PostController controller, Widget? _) {
            switch (controller.dataState) {
              case DataState.UNINITIALISED:
                Future(() {
                  controller.fetchData();
                });
                return PostListWidget(controller.dataList, false);
              case DataState.INITIAL_FETCHING:
              case DataState.MORE_FETCHING:
              case DataState.FETCHED:
              case DataState.ERROR:
              case DataState.NO_MORE_DATA:
                return PostListWidget(controller.dataList, false);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.file_copy),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePostWidget(),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }
}
