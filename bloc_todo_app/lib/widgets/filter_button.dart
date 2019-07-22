import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/blocs/filtered_todos/filtered_todos.dart';
import 'package:bloc_todo_app/models/models.dart';

/// Filter Button (Home Screen Widget)
/// 
/// ユーザーにフィルターオプションのリストを表示して、
/// 新しいフィルターが選択された時に[FilteredTodosBloc]に通知する
class FilterButton extends StatelessWidget {
  final bool visible;

  FilterButton({
    this.visible,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.body1;
    final activeStyle = Theme.of(context).textTheme.body1
      .copyWith(color: Theme.of(context).accentColor);

    final FilteredTodosBloc filteredTodosBloc = BlocProvider.of<FilteredTodosBloc>(context);
    
    return BlocBuilder(
      bloc: filteredTodosBloc,
      builder: (BuildContext context, FilteredTodosState state) {
        final button = _Button(
          // フィルター選択時
          onSelected: (filter) {
            // 選択されたフィルターをFilteredTodosBlocにdispatch
            filteredTodosBloc.dispatch(UpdateFilter(filter));
          },

          // アクティブになっているフィルター
          // 一度でもフィルタリングしたなら、そのフィルター
          // そうでなければデフォルトのall
          activeFiler: state is FilteredTodosLoaded
            ? state.activeFilter
            : VisibilityFilter.all,

          activeStyle: activeStyle,
          defaultStyle: defaultStyle,
        );

        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 150),
          child: visible ? button : IgnorePointer(child: button,),
        );
      },
    );
  }
}

/// _Button (Filter Button Widget)
/// 
/// - onSelected: 選択されたときの処理
/// - activeFilter: アクティブ状態のフィルター
/// - activeStyle: アクティブ状態のテキストのスタイル
/// - defaultStyle: デフォルトのテキストのスタイル
class _Button extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFiler;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;

  const _Button({
    Key key,
    @required this.onSelected,
    @required this.activeFiler,
    @required this.activeStyle,
    @required this.defaultStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: ArchSampleKeys.completedFilter,
      tooltip: ArchSampleLocalizations.of(context).showAll,
      onSelected: onSelected,
      icon: Icon(Icons.filter_list),
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        // All
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            ArchSampleLocalizations.of(context).showAll,
            style: activeFiler == VisibilityFilter.all
              ? activeStyle
              : defaultStyle,
          ),
        ),

        // Active
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.activeFilter,
          value: VisibilityFilter.active,
          child: Text(
            ArchSampleLocalizations.of(context).showActive,
            style: activeFiler == VisibilityFilter.active
              ? activeStyle
              : defaultStyle,
          ),          
        ),

        // Completed
        PopupMenuItem<VisibilityFilter>(
          key: ArchSampleKeys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            ArchSampleLocalizations.of(context).showCompleted,
            style: activeFiler == VisibilityFilter.completed
              ? activeStyle
              : defaultStyle,
          ),          
        ),
      ],
    );
  }
}