import 'package:bloc_practice/bloc/todo/todo_bloc.dart';
import 'package:bloc_practice/bloc/todo/todo_event.dart';
import 'package:bloc_practice/bloc/todo/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todosList.isEmpty) {
            return const Center(child: Text('No todo found'));
          } else if (state.todosList.isNotEmpty) {
            return ListView.builder(
              itemCount: state.todosList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.todosList[index]),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<TodoBloc>().add(
                        RemoveTodoEvent(todo: state.todosList[index]),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < 10; i++) {
            context.read<TodoBloc>().add(AddTodoEvent(todo: 'Task: $i'));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
