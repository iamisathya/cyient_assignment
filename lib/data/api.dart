import 'dart:convert';

import 'package:cyient_assignment/config/functions.dart';
import 'package:cyient_assignment/data/exceptions/network_exceptions.dart';
import 'package:cyient_assignment/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/post/post.dart';
import 'constants/endpoints.dart';

class APIManager {
  static final APIManager _shared = APIManager._internal();

  APIManager._internal();

  factory APIManager() {
    return _shared;
  }

  void handleError(e) {}

  Future fetchData(int currentPage) async {
    List<Post> _list = [];
    try {
      var url = Uri.parse(Endpoints.getPosts);
      var response = await http.get(url);

      var getUsersUrl = Uri.parse(Endpoints.getUsers);
      var getUsersResponse = await http.get(getUsersUrl);
      await Future.delayed(const Duration(seconds: 2));
      // merging user post with user name
      var res = processData([
        jsonDecode(response.body) as List,
        jsonDecode(getUsersResponse.body) as List
      ]);
      for (var item in res) {
        _list.add(Post.fromMap(item));
      }
    } on NetworkException catch (_) {
      throw NetworkException(message: "Network error!");
    } catch (e) {
      debugPrint(e.toString());
    }
    return _list;
  }

  Future<List<User>> fetchUsers() async {
    List<User> _list = [];
    try {
      var url = Uri.parse(Endpoints.getUsers);
      var response = await http.get(url);

      for (var item in jsonDecode(response.body) as List) {
        _list.add(User.fromMap(item));
      }
    } on NetworkException catch (_) {
      throw NetworkException(message: "Network error!");
    } catch (e) {
      debugPrint(e.toString());
    }
    return _list;
  }

  Future<void> createPost(String title, String body, int userId) async {
    try {
      var url = Uri.parse(Endpoints.getPosts);
      await Future.delayed(const Duration(seconds: 2));
      http.Response response = await http.post(url,
          body: jsonEncode({'title': title, 'body': body, 'userId': userId}));

      debugPrint(response.body.toString());
      var parsed = Post.fromMap(jsonDecode(response.body));
      if (parsed.id == null) {
        throw UnhandledException(message: "Unhandled exception");
      } else {
        debugPrint(parsed.toString());
      }
    } on NetworkException catch (_) {
      throw NetworkException(message: "Network error!");
    } catch (e, _) {
      // debugPrint(s.toString());
      debugPrint(e.toString());
    }
  }

  Future<void> updatePost(String title, String body, int userId, int id) async {
    try {
      var url = Uri.parse("${Endpoints.getPosts}/$id");
      await Future.delayed(const Duration(seconds: 2));

      http.Response response = await http.patch(url,
          body: jsonEncode(
              {'title': title, 'body': body, 'userId': userId, 'id': id}));

      debugPrint(response.body.toString());
      var parsed = Post.fromMap(jsonDecode(response.body));
      if (parsed.id == null) {
        throw UnhandledException(message: "Unhandled exception");
      } else {
        debugPrint(parsed.toString());
      }
    } on NetworkException catch (_) {
      throw NetworkException(message: "Network error!");
    } catch (e, _) {
      // debugPrint(s.toString());
      debugPrint(e.toString());
    }
  }
}
