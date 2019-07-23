import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/models/models.dart';

/// Tab Selector (Home Screen Widget)
/// 
/// ユーザーのタブの選択をハンドリングする。
/// Blocには依存していない。
/// 
/// - activeTab: 初期状態でアクティブになっているタブ
/// - onTabSelected: タブが選択された時に実行するクロージャー
class TabSelector extends StatelessWidget {
  final AppTab activeTab;

  // クロージャー的な？
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex:  AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),

      // AppTab => BottomNavigationBarItemにmap
      items: AppTab.values.map((tab) {
        Icon icon;
        String title;

        switch (tab) {
          case AppTab.todos:
            icon = Icon(
              Icons.list,
              key: ArchSampleKeys.todoTab,
            );
            title = ArchSampleLocalizations.of(context).todos;
            break;
          case AppTab.stats:
            icon = Icon(
              Icons.show_chart,
              key: ArchSampleKeys.statsTab,
            );
            title = ArchSampleLocalizations.of(context).stats;
            break;
        }

        return BottomNavigationBarItem(
          icon: icon,
          title: Text(title),
        );

        // 以下から変更(Tabの数が2つ以上になる場合を想定)
        //
        // return BottomNavigationBarItem(
        //   icon: Icon(
        //     tab == AppTab.todos ? Icons.list : Icons.show_chart,
        //     key: tab == AppTab.todos
        //         ? ArchSampleKeys.todoTab
        //         : ArchSampleKeys.statsTab,
        //   ),
        //   title: Text(tab == AppTab.stats
        //       ? ArchSampleLocalizations.of(context).stats
        //       : ArchSampleLocalizations.of(context).todos),
        // );
      }).toList(),
    );
  }
}