import 'package:flutter/material.dart';
import 'package:test_app/todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  TextEditingController ControllerText = new TextEditingController();

  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  @override
  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      },
    );
  }

  _addTodo() async {
    final todo = await showDialog<Todo>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New Todo"),
            content: TextField(
              autofocus: true,
              controller: ControllerText,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Add"),
                onPressed: () {
                  final todo = new Todo(title: ControllerText.value.text);
                  setState(() {
                    if (ControllerText.value.text != "") {
                      todos.add(todo);
                    } else {
                     print("");
                    }
                  });
                    ControllerText.clear();
                   Navigator.of(context).pop(todo);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}
