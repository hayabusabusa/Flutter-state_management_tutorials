import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_todo_app/models/models.dart';

// MARK: Bloc Event

@immutable
abstract class FilteredTodosEvent extends Equatable {
  FilteredTodosEvent([List props = const []]) : super(props);
}

/// Update Filter Event
/// 
/// 表示されているフィルターが変更された時に通知される
class UpdateFilter extends FilteredTodosEvent {
  final VisibilityFilter filter;

  UpdateFilter(this.filter) : super([filter]);

  @override
  String toString() => 'UpdateFilter { filter: $filter }';
}

/// Update Todos Event
/// 
/// todosのリストに変更があった時に通知される
class UpdateTodos extends FilteredTodosEvent {
  final List<Todo> todos;

  UpdateTodos(this.todos) : super(todos);

  @override
  String toString() => 'UpdateTodos { todos: $todos }';
}