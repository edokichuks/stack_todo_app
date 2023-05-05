import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stack_todo_app/app/locator.dart';
import 'package:stack_todo_app/models/todo.adapter.dart';

import 'ui/todo_screen/todo_screen_view.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // await Hive.initFlutter;
  //
  // Hive.registerAdapter(TodoAdapter());
  await Hive.initFlutter();
  await Hive.openBox('todos');
  setupLocator();
  Hive.registerAdapter(TodoAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TodoScreenView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Chuks Todo',
    );
  }
}
