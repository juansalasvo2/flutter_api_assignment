import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

// Define states
final todoListProvider = FutureProvider<List<Todo>>((ref) async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Todo.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load todos');
  }
});
