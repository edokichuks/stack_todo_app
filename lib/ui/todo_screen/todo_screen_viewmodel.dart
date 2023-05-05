import 'package:flutter/cupertino.dart';
import 'package:stack_todo_app/service/todo.service.dart';
import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../models/todo.dart';

class TodoScreenViewModel extends ReactiveViewModel {
  final _firstTodoFocusNode = FocusNode();
  final _todosService = locator<TodoService>();

  late final toggleStatus = _todosService.toggleStatus;

  late final updateTodoContent = _todosService.updateTodoContent;

  late final removeTodo = _todosService.removeTodo;

  List<Todo> get todos => _todosService.todos;

  void newTodo() {
    _todosService.newTodo();
    _firstTodoFocusNode.requestFocus();
  }

  FocusNode? getFocusNode(String id) {
    final index = todos.indexWhere((element) => element.id == id);

    return index == 0 ? _firstTodoFocusNode : null;
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_todosService];
}
