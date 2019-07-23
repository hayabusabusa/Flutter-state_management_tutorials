import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/blocs/todos/todos.dart';
import 'package:bloc_todo_app/models/models.dart';
import 'package:bloc_todo_app/flutter_todos_keys.dart';

/// Extra Actions (Home Screen Widget)
/// 
/// AppBar右上に表示するPopupMenu。
/// 全てのtodosを完了または完了のtodosを削除するアクションが選択可能。
class ExtraActions extends StatelessWidget {
  ExtraActions({
    Key key
  }) : super(key: ArchSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);

    return BlocBuilder(
      bloc: todosBloc,
      builder: (BuildContext context, TodosState state) {

        if (state is TodosLoaded) {
          bool allComplete = (todosBloc.currentState as TodosLoaded)
            .todos
            .every((todo) => todo.complete);
          
          return PopupMenuButton<ExtraAction>(
            key: FlutterTodosKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.toggleAllComplete:
                  todosBloc.dispatch(ToggleAll());
                  break;
                case ExtraAction.clearCompleted:
                  todosBloc.dispatch(ClearCompleted());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              // ToggleAllComplete
              PopupMenuItem<ExtraAction>(
                key: ArchSampleKeys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete 
                    ? ArchSampleLocalizations.of(context).markAllIncomplete
                    : ArchSampleLocalizations.of(context).markAllComplete
                ),
              ),

              // ClearCompleted
              PopupMenuItem<ExtraAction>(
                key: ArchSampleKeys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text(
                  ArchSampleLocalizations.of(context).clearCompleted
                ),
              )
            ],
          );
        }

        return Container(key: FlutterTodosKeys.extraActionsEmptyContainer,);
      },
    );
  }
}