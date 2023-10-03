import 'package:crud/screens/edit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Todo App',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const TaskList(),
    );
  }
}
