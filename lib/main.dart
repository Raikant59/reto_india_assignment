import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_india_assignment/model/todo_provider.dart';
import 'package:reto_india_assignment/screens/Homescreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ToDoProvider(),
      child: ToDoApp(),
    ),
  );
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}



