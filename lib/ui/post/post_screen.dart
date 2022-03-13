import 'package:cyient_assignment/data/enum.dart';
import 'package:cyient_assignment/stores/post/post_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'post_list.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cyient Assignment"),
        ),
        body: ChangeNotifierProvider(
          create: (context) => PostController(),
          child: Consumer<PostController>(builder:
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
          }),
        ));
  }
}
