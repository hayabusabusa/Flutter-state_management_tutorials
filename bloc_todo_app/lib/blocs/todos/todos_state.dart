import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_todo_app/models/models.dart';

// MARK: State

abstract class TodosState extends Equatable {
  TodosState([List props = const []]) : super(props);
}

// MARK: TodosLoading State
// repositoryからtodoをフェッチ中
class TodosLoading extends TodosState {
  @override
  String toString() => 'TodosLoading';
}

// MARK: TodosLoaded State
// repositoryからのフェッチが完了した
class TodosLoaded extends TodosState {
  final List<Todo> todos;

  TodosLoaded([this.todos]) : super(todos);

  @override
  String toString() => 'TodosLoaded { todos: $todos }';
}

// MARK: TodosNotLoaded
// todoをフェッチに失敗した場合
class TodosNotLoaded extends TodosState {
  @override
  String toString() => 'TodosNotLoaded';
}