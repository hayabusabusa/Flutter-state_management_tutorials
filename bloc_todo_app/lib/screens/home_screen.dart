import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/blocs/blocs.dart';
import 'package:bloc_todo_app/widgets/widgets.dart';
import 'package:bloc_todo_app/localization.dart';
import 'package:bloc_todo_app/models/models.dart';

/// Home Screen (Screen)
/// 
/// 全体のScaffold Widgetを作成する。
/// Bottom Navigatoin Bar、Stats / FilteredTodos Widgetを管理する。
/// タブのコントロールも行う。タブの状態に応じてAppBarのメニューを非表示にしたりもする。
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TabBlocを取り出し
    final tabBloc = BlocProvider.of<TabBloc>(context);
    
    return BlocBuilder(
      bloc: tabBloc,
      // BuildContext, Stateとして流れてくるAppTab
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          // App Bar
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: <Widget>[
              // visible = isHidden?
              FilterButton(visible: activeTab == AppTab.todos,),
              ExtraActions()
            ],
          ),
          // Body
          // TODO: Impl FilteredTodos() and Stats()
          // アクティブになっているタブに応じて
          // それに対応した画面を表示させる
          //body: activeTab == AppTab.todos ? ,
          // Floating Action Button
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              // Navigatorにキーを使って遷移
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          // Bottom Navigation Bar
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => tabBloc.dispatch(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}