import '../model/todo.dart';

class TodoController {
  Todo newTodo = new Todo();
  List<Todo> myTodoList = [];
  void add() {
    newTodo.id = myTodoList.length + 1;
    myTodoList.add(newTodo);
  }
  void edit({Todo todo, int editid}){
    myTodoList.removeWhere((item) => item.id == editid);
    todo.id = editid;
    myTodoList.add(todo);
  }
  void delete({int id}) {
    myTodoList.removeWhere((item) => item.id == id);
  }
}
