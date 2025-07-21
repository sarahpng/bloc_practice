import 'package:bloc_practice/bloc/todo/todo_event.dart';
import 'package:bloc_practice/bloc/todo/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<String> todosList = [];
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(_addTodoEvent);
    on<RemoveTodoEvent>(_removeTodoEvent);
  }
  _addTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) {
    todosList.add(event.todo);
    emit(state.copywith(todosList: List.from(todosList)));
  }

  _removeTodoEvent(RemoveTodoEvent event, Emitter<TodoState> emit) {
    todosList.remove(event.todo);
    emit(state.copywith(todosList: List.from(todosList)));
  }
}
