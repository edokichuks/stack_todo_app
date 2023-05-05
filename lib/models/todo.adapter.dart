import 'package:stack_todo_app/models/todo.dart';
import 'package:hive/hive.dart';

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  Todo read(BinaryReader reader) {
    // TODO: implement read
    //  throw UnimplementedError();
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      id: fields[0] as String,
      completed: fields[1] as bool,
      content: fields[2] as String,
    );
  }

  @override
  // TODO: implement typeId
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, Todo obj) {
    // TODO: implement write
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.completed)
      ..writeByte(2)
      ..write(obj.content);
  }
}
