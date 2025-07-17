import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger data loading when the screen is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (todoProvider.error != null) {
            return Center(child: Text('Error: ${todoProvider.error}'));
          }

          if (todoProvider.todos.isEmpty) {
            return const Center(child: Text('No todos found'));
          }

          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return ListTile(
                leading: Icon(
                  todo.completed ? Icons.check_circle : Icons.circle_outlined,
                  color: todo.completed ? Colors.green : Colors.grey,
                ),
                title: Text(todo.title),
                subtitle: Text('ID: ${todo.id}'),
              );
            },
          );
        },
      ),
    );
  }
}
