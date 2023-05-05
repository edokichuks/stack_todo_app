import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stack_todo_app/ui/todo_screen/todo_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TodoScreenView extends StatelessWidget {
  const TodoScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoScreenViewModel>.reactive(
      viewModelBuilder: () => TodoScreenViewModel(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Chuks Todo'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            if (model.todos.isEmpty)
              Opacity(
                opacity: 0.5,
                child: Center(
                  child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 100,
                      ),
                      Icon(Icons.emoji_food_beverage_outlined, size: 48),
                      Text('No todos yet. Click + to add a new one.'),
                    ],
                  ),
                ),
              ),
            ...model.todos.map(
              (todo) {
                return ListTile(
                  leading: IconButton(
                    icon: Icon(
                      todo.completed ? Icons.task_alt : Icons.circle_outlined,
                    ),
                    onPressed: () => model.toggleStatus(todo.id),
                  ),
                  title: TextField(
                    controller: TextEditingController(text: todo.content),
                    decoration: null,
                    maxLines: null,
                    focusNode: model.getFocusNode(todo.id),
                    onChanged: (text) => model.updateTodoContent(todo.id, text),
                    style: TextStyle(
                      fontSize: 20,
                      decoration:
                          todo.completed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.horizontal_rule),
                    onPressed: () => model.removeTodo(todo.id),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.newTodo(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
