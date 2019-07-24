import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/blocs/blocs.dart';
import 'package:bloc_todo_app/screens/screens.dart';
import 'package:bloc_todo_app/flutter_todos_keys.dart';

/// Detail Screen (Screen)
/// 
/// Todoの詳細画面。
/// ユーザーが選択したTodoの詳細が表示されて、
/// ユーザーはTodoを編集、削除することができる。
class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({
    Key key,
    @required this.id
  }) : super(key: key ?? ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    // TodosBlocを取り出し
    final todosBloc = BlocProvider.of<TodosBloc>(context);


    return BlocBuilder(
      bloc: todosBloc,
      builder: (BuildContext context, TodosState state) {
        // idから表示するtodoを検索
        // where()にorElseなるものがある
        final todo = (state as TodosLoaded)
        .todos
        .firstWhere((todo) => todo.id == id, orElse: () => null);
        final localizations = ArchSampleLocalizations.of(context);

        return Scaffold(
          // App Bar
          appBar: AppBar(
            title: Text(localizations.todoDetails),
            actions: <Widget>[
              IconButton(
                tooltip: localizations.deleteTodo,
                key: ArchSampleKeys.deleteTodoButton,
                icon: Icon(Icons.delete),
                onPressed: () {
                  todosBloc.dispatch(DeleteTodo(todo));
                  Navigator.pop(context, todo);
                },
              ),
            ],
          ),
          // Body
          body: todo == null
            ? Container(key: FlutterTodosKeys.emptyDetailsContainer,)
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  children: <Widget>[
                    // Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Checkbox(
                            key: FlutterTodosKeys.detailsScreenCheckBox,
                            value: todo.complete,
                            onChanged: (_) {
                              todosBloc.dispatch(
                                UpdateTodo(todo.copyWith(complete: !todo.complete))
                              );
                            },
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Hero
                              Hero(
                                tag: '${todo.id}__heroTag',
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                                  child: Text(
                                    todo.task,
                                    key: ArchSampleKeys.detailsTodoItemTask,
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                ),
                              ),

                              Text(
                                todo.note,
                                key: ArchSampleKeys.detailsTodoItemNote,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
              ),
            ),
          // Floating Action Button
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.editTodoFab,
            tooltip: localizations.editTodo,
            child: Icon(Icons.edit),
            onPressed: todo == null
              ? null
              : () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AddEditScreen(
                        key: ArchSampleKeys.editTodoScreen,
                        isEditing: true,
                        todo: todo,
                        onSave: (task, note) {
                          todosBloc.dispatch(
                            UpdateTodo(todo.copyWith(task: task, note: note))
                          );
                        },
                      );
                    }
                  )
                );
              },
          ),
        );
      },
    );
  }
}