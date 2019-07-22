import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/blocs/stats/stats.dart';
import 'package:bloc_todo_app/blocs/todos/todos.dart';

// MARk: Bloc

/// Stats Bloc
/// 
/// Stats画面のBloc。
/// todosから完了したもの、未完了のものの数を計算する。
/// TodosBlocに依存していて、TodosBlocが更新されればStatsBlocも更新される。
class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TodosBloc todosBloc;

  // TodosBlocを監視するためのもの
  StreamSubscription todosSubscription;

  StatsBloc({
    @required this.todosBloc
  }) {
    // TodosBlocから更新のStateが流れたら
    todosSubscription = todosBloc.state.listen((state) {
      if (state is TodosLoaded) {
        // 更新されたtodosを使って最新のStateを作成
        dispatch(UpdateStats(state.todos));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  void dispose() {
    todosSubscription.cancel();
    super.dispose();
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive = event.todos
        .where((todo) => !todo.complete).toList().length;
      int numCompleted = event.todos
        .where((todo) => todo.complete).toList().length;
      
      yield StatsLoaded(numActive, numCompleted);
    }
  }
}