import 'dart:convert';

import 'package:cyient_assignment/data/exceptions/network_exceptions.dart';
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

  Future fetchData(int currentPage) async {
    List<Post> _list = [];
    try {
      var url = Uri.parse(Endpoints.getPosts);
      var response = await http.get(url);

      await Future.delayed(const Duration(seconds: 2));
      for (var item in jsonDecode(response.body) as List) {
        _list.add(Post.fromMap(item));
      }
    } on NetworkException catch (_) {
      throw NetworkException(message: "Network error!");
    } catch (e) {
      debugPrint(e.toString());
    }
    return _list;
  }
}
