import 'package:cyient_assignment/data/api.dart';
import 'package:cyient_assignment/data/enum.dart';
import 'package:cyient_assignment/models/post/post.dart';
import 'package:flutter/material.dart';

class PostController extends ChangeNotifier {
  int _currentPageNumber = 0;
  final int _totalPages =
      10; // max we will get only 100 post in https://jsonplaceholder.typicode.com/posts
  DataState _dataState = DataState.UNINITIALISED;
  bool get _didLastLoad => _currentPageNumber >= _totalPages;
  DataState get dataState => _dataState;
  List<Post> _dataList = [];
  final List<Post> _allDataList = [];
  List<Post> get dataList => _dataList;
  List<Post> get getAllDataList => _allDataList;

  fetchData({bool isRefresh = false}) async {
    _dataState = (_dataState == DataState.UNINITIALISED)
        ? DataState.INITIAL_FETCHING
        : DataState.MORE_FETCHING;

    notifyListeners();
    try {
      if (_didLastLoad) {
        _dataState = DataState.NO_MORE_DATA;
      } else {
        if (_allDataList.isNotEmpty) {
          await Future.delayed(const Duration(seconds: 2));
          var _nextBatch =
              _allDataList.skip(_currentPageNumber * 10).take(10).toList();
          _dataList += _nextBatch;
          _dataState = DataState.FETCHED;
          _currentPageNumber += 1;
        } else {
          List<Post> list = await APIManager().fetchData(_currentPageNumber);
          _allDataList.clear();
          _allDataList.addAll(list);
          _dataList +=
              _allDataList.skip(_currentPageNumber * 10).take(10).toList();
          _dataState = DataState.FETCHED;
          _currentPageNumber += 1;
        }
      }
      notifyListeners();
    } catch (e) {
      _dataState = DataState.ERROR;
      notifyListeners();
    }
  }
}
