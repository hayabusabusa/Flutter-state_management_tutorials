import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/blocs/todos/todos.dart';
import 'package:bloc_todo_app/models/models.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepositoryFlutter todosRepository;

  TodosBloc({
    @required this.todosRepository
  });

  @override
  TodosState get initialState => TodosLoading();

  // MARK: mapEventToState
  // ここではcurrentStateを弄って新しいStateにするのではなく、
  // 常に一から新しいStateを生成して返している
  // もし一から新しいStateを作って、それがcurrentStateと同じ状態のインスタンスの場合
  // currentState == nextStateと見なされ、Stateは変化しない
  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    // Switchは使えない？
    // -> runTimeTypeから型が取れるらしいが、
    //    あんまりよくないらしく、 現状switchを型で判断するようにするのは不可能
    if (event is LoadTodos) {
      // Todoロード
      // Stream<Stream<Todo>>のように入子になるのでyield*？
      yield* _mapLoadTodosToState();
    } else if (event is AddTodos) {
      // Todo追加
      yield* _mapAddTodoToState(event);
    } else if (event is UpdateTodo) {
      // Todo更新
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      // Todo削除
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAll) {
      // Todo全て完了
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      // Todo完了のものを全て削除
      yield* _mapClearCompletedToState();
    }
  }

  // MARK: MapToState
  // mapEventToStateの肥大化を防ぐため
  // できるだけEvent=>Stateの変換を分けて関数にして実装する
  // 変更があった場合はrepositoryを通してローカルに保存する

  // MARK: map LoadTodos to State
  // repositoryからtodosをロードする
  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await this.todosRepository.loadTodos();
      yield TodosLoaded(
        todos.map(Todo.fromEntity).toList(),
      );
    } catch (_) {
      // Todoのロードに失敗
      yield TodosNotLoaded();
    }
  }

  // MARK: map AddTodo to State
  // 現在のtodosに新しく一つ追加してStateにして返す
  Stream<TodosState> _mapAddTodoToState(AddTodos event) async* {
    if (currentState is TodosLoaded) {
      // .. -> つけると[List<dynamic>]から[List<Todo>]になった
      // サブクラスにキャストしてくれる？
      final List<Todo> updatedTodos = List.from((currentState as TodosLoaded).todos)..add(event.todo);
      yield TodosLoaded(updatedTodos);
    }
  }

  // MARK: map UpdatedTodo to State
  // 現在のtodosに更新されたものだけ更新してStateにして返す
  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    // すでにtodosを読み込み済みで、todosがある場合
    if (currentState is TodosLoaded) {
      // currentStateをTodosLoadedにキャストしてから
      // mapで更新されたtodoのみ更新して返す
      final List<Todo> updatedTodos = 
        (currentState as TodosLoaded).todos.map((todo) {
          // idを比較して、更新されたものだけ差し替え
          return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
        })
        .toList();

      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  // MARK: map DeleteTodo to State
  // 現在のtodosから削除されたものを除外して返す
  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    if (currentState is TodosLoaded) {
      final updatedTodos = (currentState as TodosLoaded)
        .todos
        .where((todo) => todo.id != event.todo.id )
        .toList();
        
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  // MARK: map ToggleAll to State
  // 現在のtodosを全て完了にしたものを返す
  Stream<TodosState> _mapToggleAllToState() async* {
    if (currentState is TodosLoaded) {
      // forEach()で全てtrueにしないのはなぜか？
      // -> completeがfinalで定義されていて定数になっているため
      final allComplete = (currentState as TodosLoaded)
        .todos
        .every((todo) => todo.complete);
      final List<Todo> updatedTodos = (currentState as TodosLoaded)
        .todos
        .map((todo) => todo.copyWith(complete: !allComplete))
        .toList();

      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  // MARK: map ClearCompleted to State
  // 現在のtodosのcompleteがtrueになっているものだけ抽出して返す
  Stream<TodosState> _mapClearCompletedToState() async* {
    if (currentState is TodosLoaded) {
      final List<Todo> updatedTodos = (currentState as TodosLoaded)
       .todos
       .where((todo) => !todo.complete)
       .toList();
      
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}