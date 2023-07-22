import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mvvm_hive_provider/view_model/them_mode.dart';
import '../view_model/todo_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return MaterialApp(
      theme: themeModel.ifDark ? ThemeData.dark() : ThemeData.light(),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');
    final themeModel = Provider.of<ThemeModel>(context,);
    final todoViewModel = Provider.of<TodoViewModel>(context,);
    final todos = todoViewModel.todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo (Hive-MVVM-Provider Week 9 )'),
        actions: [
          IconButton(
            onPressed: () {
              themeModel.darkThemeToggle();
            },
            icon: const Icon(Icons.dark_mode_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter your todo',
              contentPadding: EdgeInsets.all(16.0),
            ),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                todoViewModel.addTodo(value);
                _controller.clear();
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                    title: Text(todo.title),
                    trailing: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) =>
                          todoViewModel.toggleTodoCompletion(todo),
                    ),
                    onLongPress: () {
                      todoViewModel.deleteTodo(todo);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Todo Deleted')));
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
