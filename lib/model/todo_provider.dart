import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _toDoItems = [];

  List<Map<String, dynamic>> get toDoItems => _toDoItems;

  ToDoProvider() {
    _loadToDoItems();
  }

  Future<void> _loadToDoItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? itemsJson = prefs.getString('toDoItems');
    if (itemsJson != null) {
      _toDoItems.addAll(List<Map<String, dynamic>>.from(json.decode(itemsJson)));
      notifyListeners();
    }
  }

  Future<void> _saveToDoItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String itemsJson = json.encode(_toDoItems);
    await prefs.setString('toDoItems', itemsJson);
  }

  void addToDoItem(String title) {
    if (title.trim().isEmpty) return;
    _toDoItems.add({'title': title, 'isComplete': false});
    _saveToDoItems();
    notifyListeners();
  }

  void toggleComplete(int index) {
    _toDoItems[index]['isComplete'] = !_toDoItems[index]['isComplete'];
    _saveToDoItems();
    notifyListeners();
  }

  void deleteToDoItem(int index) {
    _toDoItems.removeAt(index);
    _saveToDoItems();
    notifyListeners();
  }
}