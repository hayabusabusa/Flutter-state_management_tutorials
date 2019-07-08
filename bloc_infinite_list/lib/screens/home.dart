import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_infinite_list/blocs/bloc.dart';
import 'package:bloc_infinite_list/widgets/home/home_widgets.dart';

// MARK: StatefulWidget
// ScrollControllerを管理する必要があったため
// StatefullWidgetにしている
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // リストの一番下までスクロールした場合
  // Fetchのイベントをdispatchする
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder(
        bloc: _postBloc,
        builder: (BuildContext context, PostState state) {

          // 初回ロードする前
          if (state is PostUninitialized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          // エラーの場合
          if (state is PostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }

          // フェッチ完了後の場合
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                  ? BottomLoader()
                  : PostWidget(post: state.posts[index],);
              },
            );
          }
        },
      ),
    );
  }
}