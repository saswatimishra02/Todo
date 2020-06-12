import 'package:flutter/material.dart';
import '../model/todo.dart';

var _formkey = GlobalKey<FormState>();
Todo newtodo = new Todo();

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  var _textController = new TextEditingController(text: '');
  List<Todo> _myTodoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: ListView.builder(
        itemCount: _myTodoList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Text(
                    _myTodoList[index].text,
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
                          var oldid = _myTodoList[index].id;
                          var oldtext = _myTodoList[index].text;
                          _textController.text = oldtext;
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    //textbox
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: TextField(
                                        controller: _textController,
                                        decoration: InputDecoration(
                                          hintText: "Enter your task",
                                        ),
                                      ),
                                    ),
                                    //button
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: RaisedButton(
                                        onPressed: () {
                                          if (_textController.text.isEmpty) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Text(
                                                            "Please enter Something"),
                                                        RaisedButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text("Close"),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          } else {
                                            _myTodoList.removeWhere((t) =>
                                                t.id == _myTodoList[index].id);
                                            _myTodoList.add(
                                              Todo(
                                                  id: oldid,
                                                  text: _textController.text),
                                            );
                                            Navigator.pop(context);
                                            _textController.clear();
                                            setState(() {});
                                          }
                                        },
                                        child: Text("Submit"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _myTodoList.removeWhere(
                              (element) => element.id == _myTodoList[index].id);
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
              return Dialog(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: TextFormField(
                          decoration:
                              InputDecoration(hintText: "Enter your task"),
                          onSaved: (String value) {
                            newtodo.text = value;
                          },
                          validator: (value) =>
                              value.isEmpty ? "please enter something" : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: RaisedButton(
                          onPressed: () {
                            newtodo.id =_myTodoList.length + 1;
                            _myTodoList.add(newtodo);
                            Navigator.pop(context);
                            _textController.clear();
                            setState(() {});
                          },
                          child: Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
