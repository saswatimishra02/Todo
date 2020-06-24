class Todo {
  int id;
  String text;

  Todo({this.id, this.text});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task'] = this.text;
    return data;
  }
}