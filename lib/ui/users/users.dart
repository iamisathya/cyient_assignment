// ignore_for_file: must_be_immutable

import 'package:cyient_assignment/models/user/user.dart';
import 'package:cyient_assignment/stores/post/post_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListWidget extends StatelessWidget {
  UserListWidget({Key? key}) : super(key: key);
  late User? _selectedUser;
  late List<User> _data;

  @override
  Widget build(BuildContext context) {
    _selectedUser =
        Provider.of<PostController>(context, listen: false).selectedUser;
    _data = Provider.of<PostController>(context, listen: false).userList;
    return _dropDownWidget(context);
  }

  Widget _dropDownWidget(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<User>(
          value: _selectedUser,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (User? newValue) {
            Provider.of<PostController>(context, listen: false)
                .updateUser(newValue!);
          },
          items: _data.map<DropdownMenuItem<User>>((User value) {
            return DropdownMenuItem<User>(
              value: value,
              child: Text(value.name!),
            );
          }).toList(),
        ),
      ),
    );
  }
}
