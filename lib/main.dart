import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Task> _tasks = [];

  void _addTask(String taskName) {
    setState(() {
      _tasks.add(Task(name: taskName, isCompleted: false));
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Agregar nueva tarea'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Agregar'),
              onPressed: () {
                _addTask(newTask);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return Container(
            color: _tasks[index].isCompleted ? Colors.green : Colors.transparent,
            child: ListTile(
              title: Text(
                _tasks[index].name,
                style: TextStyle(
                  color: _tasks[index].isCompleted ? Colors.white : Colors.black,
                  decoration: _tasks[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: _tasks[index].isCompleted ? Colors.white : Colors.black,
                ),
              ),
              leading: Checkbox(
                value: _tasks[index].isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    _tasks[index].isCompleted = value ?? false;
                  });
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _removeTask(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        tooltip: 'Agregar Tarea',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String name;
  bool isCompleted;
  Task({required this.name, this.isCompleted = false});
}