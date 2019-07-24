import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/blocs/stats/stats.dart';
import 'package:bloc_todo_app/widgets/widgets.dart';
import 'package:bloc_todo_app/flutter_todos_keys.dart';

class Stats extends StatelessWidget {
  Stats({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // BlocProviderで取り出しはなし
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {

        // ロード中
        if (state is StatsLoading) {
          return LoadingIndicator(key: FlutterTodosKeys.statsLoadingIndicator);
        // ロード完了
        } else if (state is StatsLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Completed Title
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    ArchSampleLocalizations.of(context).completedTodos,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),

                // Completed
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    '${state.numCompleted}',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),

                // Active Title
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    ArchSampleLocalizations.of(context).activeTodos,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),

                // Active
                Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "${state.numActive}",
                    key: ArchSampleKeys.statsNumActive,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
              ],
            ),
          );
        // 空っぽ
        } else {
          return Container(key: FlutterTodosKeys.emptyStatsContainer);
        }
      },
    );
  }
}