// ignore_for_file: must_be_immutable

import 'package:cyient_assignment/data/enum.dart';
import 'package:cyient_assignment/models/post/post.dart';
import 'package:cyient_assignment/stores/post/post_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/post_item.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> _data;
  bool _isLoading;
  PostListWidget(this._data, this._isLoading, {Key? key}) : super(key: key);
  late DataState _dataState;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _dataState = Provider.of<PostController>(context, listen: false).dataState;
    _buildContext = context;
    return SafeArea(child: _scrollNotificationWidget());
  }

  Widget _scrollNotificationWidget() {
    return Stack(
      children: [
        if (_dataState == DataState.INITIAL_FETCHING) // showing progress for initial fetching
        const Positioned(
          child: Align(
              alignment: Alignment.center, child: CircularProgressIndicator()),
        ),
        Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: _scrollNotification,
                child: ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return PostItem(data: _data, index: index);
                  },
                ),
              ),
            ),
            if (_dataState == DataState.MORE_FETCHING)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Center(
                        child: Text("Showing catched data with pagintation")),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (!_isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _isLoading = true;
      Provider.of<PostController>(_buildContext, listen: false).fetchData();
    }
    return true;
  }
}
