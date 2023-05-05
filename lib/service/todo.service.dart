import 'dart:math';

import 'package:hive/hive.dart';
import 'package:stack_todo_app/models/todo.dart';
import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoService with ReactiveServiceMixin {
  final _todos = ReactiveValue<List<Todo>>(
    Hive.box('todos').get('todos', defaultValue: []).cast<
        Todo>(), //the casting as an TOdo object is very important cux if u miss it..flutter will throw an error
  );
  final _random = Random();

  String _randomId() {
    return String.fromCharCodes(
      List.generate(10, (_) => _random.nextInt(33) + 80),
    );
  }

  List<Todo> get todos => _todos.value;

  ///The getter method is used to access the private reactive TodoList(_todo.value)

  TodoService() {
    listenToReactiveValues([_todos]);
  }

  void _saveTOHive() => Hive.box('todos').put('todos', _todos.values);

  void newTodo() {
    _todos.value.insert(
        0, Todo(id: _randomId())); //this adds the todo at the end of the list
    _saveTOHive();
    notifyListeners();
  }

  bool removeTodo(String id) {
    final index = _todos.value.indexWhere((element) => element.id == id);
    if (index != -1) {
      _todos.value.removeAt(index);
      _saveTOHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool toggleStatus(String id) {
    final index = _todos.value.indexWhere((element) => element.id == id);

    if (index != -1) {
      _todos.value[index].completed = !_todos.value[index].completed;

      _saveTOHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool updateTodoContent(String id, String text) {
    final index = _todos.value.indexWhere((element) => element.id == id);

    if (index != -1) {
      _todos.value[index].content = text;
      _saveTOHive();
      // notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
