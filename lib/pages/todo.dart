import 'package:flutter/material.dart';

import '../controllers/todo.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  var _formkey = GlobalKey<FormState>();
  TodoController todoController = new TodoController();
  Widget appForm({String initialText = '', int editid}) {
    return Dialog(
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: TextFormField(
                initialValue: initialText,
                decoration: InputDecoration(
                  hintText: "Enter your task",
                ),
                onSaved: (String value) {
                  todoController.newTodo.text = value;
                },
                validator: (value) =>
                    value.isEmpty ? "please enter something" : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: RaisedButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    if (editid != null) {
                      todoController.edit(
                          todo: todoController.newTodo, editid: editid);
                    } else {
                      todoController.add();
                    }
                    Navigator.pop(context);
                    setState(() {});
                  }
                  return;
                },
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: ListView.builder(
        itemCount: todoController.myTodoList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text(
                    todoController.myTodoList[index].text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return appForm(
                                initialText:
                                    todoController.myTodoList[index].text,
                                editid: todoController.myTodoList[index].id,
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          todoController.delete(
                              id: todoController.myTodoList[index].id);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _myTodoList.add(Todo(id: 1, text: "hello"));
          // setState(() {});
          showDialog(
            context: context,
            builder: (context) {
              return appForm();
            },
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
