import 'package:get_it/get_it.dart';
import 'package:stack_todo_app/service/todo.service.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => TodoService());
}
