import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsyncValue = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: todoAsyncValue.when(
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              leading: Icon(
                  todo.completed ? Icons.check_circle : Icons.circle_outlined,
                  color: todo.completed ? Colors.green : Colors.grey),
              title: Text(todo.title),
              subtitle: Text('ID: ${todo.id}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
