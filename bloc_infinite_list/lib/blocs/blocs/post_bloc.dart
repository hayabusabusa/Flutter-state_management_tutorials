import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bloc_infinite_list/models/post.dart';
import 'package:bloc_infinite_list/blocs/events/post_event.dart';
import 'package:bloc_infinite_list/blocs/States/post_state.dart';

// MARK: PostBloc
// PostEventを入力として受け取り、
// PostStateに変換して出力する
class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({
    @required this.httpClient
  });

  // MARK: initialState
  // 初期状態ではまだ初回ロードが済んでいないため、
  // PostUninitializedがinitialStateになる
  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {

    // フェッチのイベントが飛んできて、かつ今現在の表示件数が最大数に達していない場合
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {

        // 初回ロードなら
        if (currentState is PostUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
        }
        
        // ロード成功後の状態なら
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts((currentState as PostLoaded).posts.length, 20);

          // フェッチの結果が空だった場合は
          // 表示件数のリミットになった状態にしてそのまま返す
          yield posts.isEmpty
            ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
            : PostLoaded(
              posts: (currentState as PostLoaded).posts + posts,
              hasReachedMax: false
            );
        }
      } catch (_) {
        // エラーを dispatch する
        yield PostError();
      }
    }
    yield null;
  }

  // 最大件数に達しているかどうかを返す
  bool _hasReachedMax(PostState state) => state is PostLoaded && state.hasReachedMax;

  // PostをAPIからフェッチしてくる処理
  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get('https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;

      // jsonのデータからmapさせてクラスに変換する
      // まあまあありだと思う。
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}