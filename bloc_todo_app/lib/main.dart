import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/localization.dart';
import 'package:bloc_todo_app/blocs/blocs.dart';
import 'package:bloc_todo_app/models/models.dart';
import 'package:bloc_todo_app/screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    BlocProvider(
      builder: (cotext) {
        // TodosBlocを初期化
        // LoadTodosをdispatchして初回ロード
        //
        // TodosAppをBlocProviderでラップする。
        // これでTodosBlocがWidget Tree全体に反映されて、
        // flutter_blocが破棄などの管理をしてくれる。
        return TodosBloc(
          todosRepository: const TodosRepositoryFlutter(
            fileStorage: const FileStorage(
              '__flutter_bloc_app__',
              getApplicationDocumentsDirectory,
            ),
          ),
        )..dispatch(LoadTodos());
      },
      child: TodosApp(),
    ),
  );
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);

    return MaterialApp(
      title: FlutterBlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        FlutterBlocLocalizationsDelegate(),
      ],
      // Route
      // Key Valueっぽい書き方になるので注意
      routes: {
        // MARK: MultiBlocProvider
        // 以下と同じような書き方
        //
        // BlocProvider<TabBloc>(
        //   builder: (context) => TabBloc(),
        //   child: BlocProvider<FilteredTodosBloc>(
        //     builder: (context) => FilteredTodosBloc(todosBloc: todosBloc),
        //     child: BlocProvider<StatsBloc>(
        //       builder: (context) => StatsBloc(todosBloc: todosBloc),
        //       child: Scaffold(...),
        //     ),
        //   ),
        // );
        ArchSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<TabBloc>(
                builder: (context) => TabBloc(),
              ),

              BlocProvider<FilteredTodosBloc>(
                builder: (context) => FilteredTodosBloc(todosBloc: todosBloc),
              ),

              BlocProvider<StatsBloc>(
                builder: (context) => StatsBloc(todosBloc: todosBloc),
              ),
            ],
            child: HomeScreen(),
          );
        },

        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            key: ArchSampleKeys.addTodoScreen,
            isEditing: false,
            onSave: (task, note) {
              todosBloc.dispatch(
                AddTodos(Todo(task, note: note)),
              );
            },
          );
        }
      },
    );
  }
}