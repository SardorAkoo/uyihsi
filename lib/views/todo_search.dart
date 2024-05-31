import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uyihsi/controllers/todo_controllers.dart';
import 'package:uyihsi/models/todo.dart';

class HomeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoController()),
        ChangeNotifierProvider(create: (context) => NoteController()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rejalar va Eslatmalar'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Rejalar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TodoListScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Eslatmalar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NoteListScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoController = Provider.of<TodoController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Eslatmalar'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todoController.todos.length,
              itemBuilder: (context, index) {
                final todo = todoController.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      todoController.toggleTodoStatus(todo.id);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditTodoDialog(context, todoController, todo);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          todoController.deleteTodo(todo.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTodoDialog(context, todoController);
        },
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context, TodoController todoController) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Reja qo\'shish'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Rejani qoshish'),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    InputDecoration(hintText: 'Rejaning mazmuni qoshish'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Bekor qilish'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Qo\'shish'),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  todoController.addTodo(titleController.text,
                      descriptionController.text, selectedDate);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditTodoDialog(
      BuildContext context, TodoController todoController, Todo todo) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    DateTime selectedDate = todo.date;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rejani tahrirlash'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Reja'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Rejani mazmuni '),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Bekor qilish'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Saqlash'),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  todoController.updateTodo(todo.id, titleController.text,
                      descriptionController.text, selectedDate);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteController = Provider.of<NoteController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Eslatmalar'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: noteController.notes.length,
              itemBuilder: (context, index) {
                final note = noteController.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditNoteDialog(context, noteController, note);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          noteController.deleteNote(note.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddNoteDialog(context, noteController);
        },
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, NoteController noteController) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eslatma qo\'shish'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Sarlavha'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: 'Mazmun'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Bekor qilish'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Qo\'shish'),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  noteController.addNote(
                    titleController.text,
                    contentController.text,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(
      BuildContext context, NoteController noteController, Note note) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    titleController.text = note.title;
    contentController.text = note.content;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eslatmani tahrirlash'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Sarlavha'),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: 'Mazmun'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Bekor qilish'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Saqlash'),
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    contentController.text.isNotEmpty) {
                  noteController.updateNote(
                    note.id,
                    titleController.text,
                    contentController.text,
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
