import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_todo_app/models/models.dart';

// MARK: Bloc Event

@immutable
abstract class TabEvent extends Equatable {
  TabEvent([List props = const []]) : super(props);
}

/// Update Tab (Tab Bloc Event)
/// 
/// アクティブになっているタブの更新を通知する
class UpdateTab extends TabEvent {
  final AppTab tab;

  UpdateTab(
    this.tab
  ) : super([tab]);

  @override
  String toString() => 'UpdateTab { tab: $tab }';
}