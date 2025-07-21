import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> todosList;
  const TodoState({this.todosList = const []});

  @override
  List<Object?> get props => [todosList];

  TodoState copywith({List<String>? todosList}) {
    return TodoState(todosList: todosList ?? this.todosList);
  }
}
