import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_todo_app/models/models.dart';

// MARK: Bloc Event

@immutable
abstract class StatsEvent extends Equatable {
  StatsEvent([List props = const []]) : super(props);
}

/// Update Stats(Stats Bloc Event)
/// 
/// Stats画面の統計情報の更新を通知する
class UpdateStats extends StatsEvent {
  final List<Todo> todos;

  UpdateStats(this.todos) : super([todos]);

  @override
  String toString() => 'UpdateStats { todos: $todos }';
}