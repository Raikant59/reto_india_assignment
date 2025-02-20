import 'package:reto_india_assignment/model/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToDoScreen extends StatefulWidget {
  @override
  _AddToDoScreenState createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Provider.of<ToDoProvider>(context, listen: false)
          .addToDoItem(_controller.text.trim());
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add To-Do'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'To-Do Title',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your task here',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Add'),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}