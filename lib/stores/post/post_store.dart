// ignore_for_file: deprecated_member_use


import 'package:cyient_assignment/config/functions.dart';
import 'package:cyient_assignment/data/api.dart';
import 'package:cyient_assignment/data/enum.dart';
import 'package:cyient_assignment/models/post/post.dart';
import 'package:cyient_assignment/models/user/user.dart';
import 'package:flutter/material.dart';

class PostController extends ChangeNotifier {
  int _currentPageNumber = 0;
  final int _totalPages =
      10; // max we will get only 100 post in https://jsonplaceholder.typicode.com/posts
  DataState _dataState = DataState.UNINITIALISED;
  UserState _userState = UserState.UNINITIALISED;
  CreatePostState _createPostState = CreatePostState.UNINITIALISED;
  UpdatePostState _updatePostState = UpdatePostState.UNINITIALISED;
  bool get _didLastLoad => _currentPageNumber >= _totalPages;
  DataState get dataState => _dataState;
  UserState get userState => _userState;
  CreatePostState get createPostState => _createPostState;
  UpdatePostState get updatePostState => _updatePostState;
  List<Post> _dataList = [];
  final List<Post> _allDataList = [];
  final List<User> _allUserList = [];
  List<Post> get dataList => _dataList;
  List<User> get userList => _allUserList;
  List<Post> get getAllDataList => _allDataList;
  User? selectedUser;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get bodyController => _bodyController;

  fetchData() async {
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
          List<User> usersList = await APIManager().fetchUsers();
          final res = processData(list, usersList);
          _allUserList.addAll(usersList);
          _allDataList.clear();
          _allDataList.addAll(res);
          _dataList +=
              _allDataList.skip(_currentPageNumber * 10).take(10).toList();
          _dataState = DataState.FETCHED;
          _currentPageNumber += 1;
        }
      }
      notifyListeners();
    } catch (e, s) {
      debugPrint(s.toString());
      _dataState = DataState.ERROR;
      notifyListeners();
    }
  }

  fetchUsers() async {
    _userState = UserState.FETCHING;
    _allUserList.clear();
    notifyListeners();
    try {
      List<User> list = await APIManager().fetchUsers();
      _allUserList.addAll(list);
      _userState = UserState.FETCHED;
      notifyListeners();
    } catch (e) {
      _userState = UserState.ERROR;
      notifyListeners();
    }
  }

  updateUser(User user) async {
    selectedUser = user;
    notifyListeners();
  }

  createPost(BuildContext context) async {
    _createPostState = CreatePostState.CREATING;
    notifyListeners();
    try {
      await APIManager().createPost(
          titleController.text, bodyController.text, selectedUser!.id!);

      _createPostState = CreatePostState.CREATED;
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _createPostState = CreatePostState.ERROR;
      notifyListeners();
    }
  }

  updatePost(BuildContext context, int postId) async {
    _updatePostState = UpdatePostState.UPDATING;
    notifyListeners();
    try {
      await APIManager().updatePost(
          titleController.text, bodyController.text, selectedUser!.id!, postId);

      _updatePostState = UpdatePostState.UPDATED;
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _updatePostState = UpdatePostState.ERROR;
      notifyListeners();
    }
  }

  void showInSnackBar(String value) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(value)));
  }

  void fillCreatePostField(Post post) {
    titleController.text = post.title!;
    bodyController.text = post.body!;
    selectedUser = userList.firstWhere((element) => element.id == post.userId);
  }

  void deletePost(int postId) {
    _dataList.removeAt(postId);
    notifyListeners();
  }
}
