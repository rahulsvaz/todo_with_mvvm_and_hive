import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  final Box<Todo> _todoBox = Hive.box<Todo>('todos');

  List<Todo> get todos => _todoBox.values.toList();

  void addTodo(String title) {
    final newTodo = Todo(title: title);
    _todoBox.add(newTodo);
    notifyListeners();
  }

  void toggleTodoCompletion(Todo todo) {
    todo.isCompleted = !todo.isCompleted;
    todo.save();
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    todo.delete();
    notifyListeners();
  }
}

