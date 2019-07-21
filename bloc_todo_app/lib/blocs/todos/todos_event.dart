import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_todo_app/models/models.dart';

// MARK: Bloc Event

@immutable
abstract class TodosEvent extends Equatable {
  TodosEvent([List props = const []]) : super(props);
}

// MARK: LoadTodos Event
// TodosRepositoryからtodosをロードする
class LoadTodos extends TodosEvent {
  @override
  String toString() => 'LoadTodos';
}

// MARK: AddTodos Event
// todoをリストに追加する
class AddTodos extends TodosEvent {
  final Todo todo;

  AddTodos(this.todo) : super([todo]);

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

// MARK: UpdateTodo Event
// すでにあるtodoを更新する
class UpdateTodo extends TodosEvent {
  final Todo updatedTodo;

  UpdateTodo(this.updatedTodo) : super([updatedTodo]);

  @override
  String toString() => 'UpdateTodo { updateTodo: $updatedTodo }';
}

// MARK: DeleteTodo Event
// すでにあるtodoを削除する
class DeleteTodo extends TodosEvent {
  final Todo todo;

  DeleteTodo(this.todo) : super([todo]);

  @override
  String toString() => 'DeleteTodo { todo: $todo }';
}

// MARK: ClearCompleted Event
// 完了したtodoを削除する
class ClearCompleted extends TodosEvent {
  @override
  String toString() => 'ClearCompleted';
}

// MARK: ToggleAll Event
// 全てのtodoの完了状態を切り替える
class ToggleAll extends TodosEvent {
  @override
  String toString() => 'ToggleAll';
}