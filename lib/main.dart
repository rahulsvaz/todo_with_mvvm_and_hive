import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo_mvvm_hive_provider/view/home_screen.dart';
import 'package:todo_mvvm_hive_provider/view_model/them_mode.dart';
import 'package:todo_mvvm_hive_provider/view_model/todo_view_model.dart';

import 'models/todo_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  runApp( MultiProvider( 
    providers: [
        ChangeNotifierProvider(
          create: (_) => TodoViewModel(),
        ),
        ChangeNotifierProvider(create: (_) => ThemeModel())
      ],
    child:const  MyApp()));
}
