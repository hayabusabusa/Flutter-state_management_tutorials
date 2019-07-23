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

              return TodoItem(
                todo: todo,
                // スワイプで削除
                onDismissed: (direction) {
                  todosBloc.dispatch(DeleteTodo(todo));

                  Scaffold.of(context).showSnackBar(
                    DeleteTodoSnackBar(
                      key: ArchSampleKeys.snackbar,
                      todo: todo,
                      onUndo: () => todosBloc.dispatch(AddTodos(todo)),
                      localizations: localizations,
                    )
                  );
                },

                // セルをタップした時
                onTap: () async {
                  final removedTodo = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return DetailsScreen(id: todo.id,);
                      }
                    )
                  );

                  if (removedTodo != null) {
                    Scaffold.of(context).showSnackBar(
                      DeleteTodoSnackBar(
                        key: ArchSampleKeys.snackbar,
                        todo: todo,
                        onUndo: () => todosBloc.dispatch(AddTodos(todo)),
                        localizations: localizations,
                      )
                    );
                  }
                },

                // チェックボックスの状態が変わった時
                onCheckBoxChanged: (_) {
                  todosBloc.dispatch(
                    UpdateTodo(todo.copyWith(complete: !todo.complete))
                  );
                },
              );
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