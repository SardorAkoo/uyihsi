class Todo {
  String id;
  String title;
  String description;
  DateTime date;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
  });
}

class Note {
  String id;
  String title;
  String content;
  DateTime createdDate;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdDate,
  });
}
