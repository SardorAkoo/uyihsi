import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:uyihsi/models/todo.dart';


class TodoController extends ChangeNotifier {
  List<Todo> _todos = [];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  void addTodo(String title, String description, DateTime date) {
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      date: date,
    );
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(
      String id, String newTitle, String newDescription, DateTime newDate) {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    todo.title = newTitle;
    todo.description = newDescription;
    todo.date = newDate;
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
  }

  int get completedCount => _todos.where((todo) => todo.isCompleted).length;

  int get pendingCount => _todos.where((todo) => !todo.isCompleted).length;
}

class NoteController extends ChangeNotifier {
  List<Note> _notes = [];

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  void addNote(String title, String content) {
    final note = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
      createdDate: DateTime.now(),
    );
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(String id, String newTitle, String newContent) {
    final note = _notes.firstWhere((note) => note.id == id);
    note.title = newTitle;
    note.content = newContent;
    notifyListeners();
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
