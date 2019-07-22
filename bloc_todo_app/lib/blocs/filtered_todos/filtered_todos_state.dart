import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_todo_app/models/models.dart';

// MARK: Bloc State

@immutable
abstract class FilteredTodosState extends Equatable {
  FilteredTodosState([List props = const []]) : super(props);
}

/// Filtered Todos Loading State
/// 
/// フィルタリングされたtodosを読み込み中の状態
class FilteredTodosLoading extends FilteredTodosState {
  @override
  String toString() => 'FilteredTodosLoading';
}

/// Filtered Todos Loaded State
/// 
/// フィルタリングされたtodosを読み込み完了した状態
class FilteredTodosLoaded extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  FilteredTodosLoaded(
    this.filteredTodos,
    this.activeFilter
  ) : super([filteredTodos, activeFilter]);

  @override
  String toString() => 'FilteredTodosLoaded { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
}