// ignore_for_file: library_private_types_in_public_api

import 'package:crud/model/add_task.dart';
import 'package:crud/services/api.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    fetchTodos().then((todoList) {
      setState(() {
        todos = todoList;
      });
    });
  }

//function to edit Dialog box

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return GestureDetector(
            onTap: () {
              _showEditDialog(todo);
            },
            child: Dismissible(
              key: Key(todos[index].id.toString()),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {
                setState(() {
                  todos.removeAt(index);
                });
                saveTodos(todos);
              },
              child: ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      todo.isCompleted = value!;
                      saveTodos(todos);
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

//method to insert data in the todoapp
  void _addTodo() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                final String title = titleController.text;
                final String description = descriptionController.text;

                if (title.isNotEmpty) {
                  final Todo newTodo = Todo(
                    id: todos.length + 1,
                    title: title,
                    description: description,
                    isCompleted: false,
                  );

                  setState(() {
                    todos.add(newTodo);
                  });
                  saveTodos(todos);

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

//method to update the data in the dialogbox

    void _showEditDialog(Todo todo) {
    final TextEditingController titleController =
        TextEditingController(text: todo.title);
    final TextEditingController descriptionController =
        TextEditingController(text: todo.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Update the title and description of the todo item
                todo.title = titleController.text;
                todo.description = descriptionController.text;

                // Save the updated todos list
                saveTodos(todos);

                // Close the dialog
                Navigator.of(context).pop();
                // Optionally, you can call setState here to refresh the UI
                setState(() {});
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

}
