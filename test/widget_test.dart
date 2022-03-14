// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cyient_assignment/ui/post/create_post/create_post.dart';
import 'package:cyient_assignment/ui/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cyient_assignment/main.dart';

void main() {
  testWidgets('Listview with 10 items', (WidgetTester tester) async {
    await tester.pumpWidget(PostScreen());

    // Create the Finders.
    expect(find.byKey(const Key("post_list_key")), findsOneWidget);    
  });

  testWidgets('Testing create post widget', (WidgetTester tester) async {
    await tester.pumpWidget(const CreatePostWidget(post: null));

    // Create the Finders.
    expect(find.byKey(const Key("title_field_key")), findsOneWidget);    
    expect(find.byKey(const Key("body_field_key")), findsOneWidget);    
    expect(find.byKey(const Key("create_button_key")), findsOneWidget);  
  });
}
