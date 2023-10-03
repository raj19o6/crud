import 'dart:convert';

import 'package:crud/model/add_task.dart';
import 'package:flutter/services.dart';

Future<List<Todo>> fetchTodos() async {
  try {
    final String data = await rootBundle.loadString('assets/db.json');
    final List<dynamic> jsonList = json.decode(data);
    return jsonList.map((json) => Todo.fromJson(json)).toList();
  } catch (error) {
    // ignore: avoid_print
    print('Error fetching Todos: $error');
    return <Todo>[];
  }
}

Future<void> saveTodos(List<Todo> todos) async {
  final List<Map<String, dynamic>> jsonList =
      todos.map((todo) => todo.toJson()).toList();
  // ignore: unused_local_variable
  final String jsondata = json.encode(jsonList);
  await rootBundle.loadString('assets/db.json');
}
