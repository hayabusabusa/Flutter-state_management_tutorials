import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// MARK: Bloc State

@immutable
abstract class StatsState extends Equatable {
  StatsState([List props = const []]) : super(props);
}

/// Stats Loading (Stats Bloc State)
/// 
/// 現在の統計情報を計算中の状態
class StatsLoading extends StatsState {
  @override
  String toString() => 'StatsLoading';
}

/// Stats Loaded (Stats Bloc State)
/// 
/// todosから現在の統計情報を計算済みの状態
class StatsLoaded extends StatsState {
  final int numActive;
  final int numCompleted;

  StatsLoaded(
    this.numActive,
    this.numCompleted
  ) : super([numActive, numCompleted]);

  @override
  String toString() => 'StatsLoaded { numActive: $numActive, numCompleted: $numCompleted }';
}