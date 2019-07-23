import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/blocs/blocs.dart';
import 'package:bloc_todo_app/widgets/widgets.dart';
import 'package:bloc_todo_app/screens/screens.dart';
import 'package:bloc_todo_app/flutter_todos_keys.dart';

/// Filtered Todos
/// 
/// 現在アクティブになっているフィルターに応じて、
/// フィルタリングされたtodosを返す。
/// 
/// FilteredTodosBlocは現在のフィルターに応じて、
/// 正しいTodoを表示するために使う。
/// 
/// TodosBlocはユーザーの操作に応じてTodoの追加、削除を通知させるために使う。
class FilteredTodos extends StatelessWidget {
  FilteredTodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    final filteredTodosBloc = BlocProvider.of<FilteredTodosBloc>(context);
    final localizations = ArchSampleLocalizations.of(context);

    return BlocBuilder(
      bloc: filteredTodosBloc,
      builder: (BuildContext context, FilteredTodosState state) {
        // ロード中
        if (state is FilteredTodosLoading) {
          return LoadingIndicator();
        // フィルタリングされたtodosがロードされた
        } else if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;

          return ListView.builder(
            key: ArchSampleKeys.todoList,
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];

              // TODO: Impl TodoItem Widget
            },
          );
        // それ以外
        } else {
          return Container(key: FlutterTodosKeys.filteredTodosEmptyContainer);
        }
      },
    );
  }
}