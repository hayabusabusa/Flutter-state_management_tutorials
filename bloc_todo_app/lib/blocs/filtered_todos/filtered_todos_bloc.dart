import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc_todo_app/blocs/filtered_todos/filtered_todos.dart';
import 'package:bloc_todo_app/blocs/todos/todos.dart';
import 'package:bloc_todo_app/models/models.dart';

// MARK: Bloc

/// Filtered Todos Bloc
/// 
/// TodosRepositoryに依存するのではなく、
/// TodosBlocに依存している。これによりTodosBlocの状態変化に応じて状態を更新する。
/// TodosBlocが更新された際には[UpdateTodos]Eventをdispatchさせる。
class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;

  // StreamSubscription
  // TodosBlocを監視するためのもの
  StreamSubscription todosSubscription;

  FilteredTodosBloc({
    @required this.todosBloc
  }) {
    // StreamSubscriptionに監視するstateを登録
    // todosが更新された際にはUpdateTodosのEventをdispatchする
    todosSubscription = todosBloc.state.listen((state) {
        // 監視しているstateがTodosLoaded(すでにtodosを読み込み済み)の時のみ
        if (state is TodosLoaded) {
          // これはFilteredTodosBlocにdispatch
          dispatch(UpdateTodos((todosBloc.currentState as TodosLoaded).todos));
        }
    });
  }

  @override
  FilteredTodosState get initialState {
    // TodosBlocのcurrentStateがTodosLoadedの場合
    // FilteredTodosLoadedをall(全て表示)の状態で初期化
    return todosBloc.currentState is TodosLoaded
      ? FilteredTodosLoaded(
          (todosBloc.currentState as TodosLoaded).todos, 
          VisibilityFilter.all
        )
      : FilteredTodosLoading();
  }

  @override
  void dispose() {
    todosSubscription.cancel();
    super.dispose();
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdateTodos) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  // MARK: MapToState

  /// Map UpdateFilter(FilteredTodosBloc Event) To State
  /// 
  /// フィルターが更新されたEventを受け取って、
  /// フィルターに応じた状態のtodosをのせたStateを返す。
  Stream<FilteredTodosState> _mapUpdateFilterToState(UpdateFilter event) async* {
    if (todosBloc.currentState is TodosLoaded) {
      yield FilteredTodosLoaded(
        _mapTodosToFilteredTodos(
          (todosBloc.currentState as TodosLoaded).todos,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  /// Map TodosUpdateed(FilteredTodosBloc Event) To State
  /// 
  /// todosが更新されたEventを受け取って、
  /// 現在フィルターをかけた状態のtodosを表示しているならそのフィルターを適応させたtodosを返して、
  /// フィルターがデフォルトの[all]のままならそのまま全てを表示させる。
  Stream<FilteredTodosState> _mapTodosUpdatedToState(UpdateTodos event) async* {
    final visibilityFilter = currentState is FilteredTodosLoaded
      ? (currentState as FilteredTodosLoaded).activeFilter
      : VisibilityFilter.all;
    
    yield FilteredTodosLoaded(
      _mapTodosToFilteredTodos(
          (todosBloc.currentState as TodosLoaded).todos,
          visibilityFilter,
        ),
        visibilityFilter,
    );
  }

  /// Map Todos To FilteredTodos
  /// 
  /// 引数に指定したVisibilityFilterに応じてTodosを変化させて返す。
  List<Todo> _mapTodosToFilteredTodos(List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      // if else のところをswitchに変更してみた
      switch (filter) {
        case VisibilityFilter.all:
          return true;
        case VisibilityFilter.active:
          return !todo.complete;
        case VisibilityFilter.completed:
          return todo.complete;
      }

      // if (filter == VisibilityFilter.all) {
      //   return true;
      // } else if (filter == VisibilityFilter.active) {
      //   return !todo.complete;
      // } else if (filter == VisibilityFilter.completed) {
      //   return todo.complete;
      // }
    }).toList();
  }
}