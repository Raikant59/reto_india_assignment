import 'package:reto_india_assignment/model/todo_provider.dart';
import 'package:reto_india_assignment/screens/add_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toDoProvider = Provider.of<ToDoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: toDoProvider.toDoItems.isEmpty
          ? Center(
        child: Text(
          'No to-do items yet. Add some!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: toDoProvider.toDoItems.length,
        itemBuilder: (context, index) {
          final item = toDoProvider.toDoItems[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              toDoProvider.deleteToDoItem(index);
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(
                leading: Checkbox(
                  value: item['isComplete'],
                  onChanged: (value) => toDoProvider.toggleComplete(index),
                ),
                title: Text(
                  item['title'],
                  style: TextStyle(
                    decoration: item['isComplete']
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddToDoScreen(),
            ),
          );

          if (result == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No To-Do item was added.')),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}