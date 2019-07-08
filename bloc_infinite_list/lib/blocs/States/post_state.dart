import 'package:equatable/equatable.dart';
import 'package:bloc_infinite_list/models/post.dart';

abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

// MARK: PostUninitialized
// 初回の情報をロードしている間かどうか
class PostUninitialized extends PostState {
  @override
  String toString() => 'PostUninitialized';
}

// MARK: PostError
// データを取得中にエラーが発生したかどうか
class PostError extends PostState {
  @override
  String toString() => 'PostError';
}

// MARK: PostLoaded
// データの取得が完了し、取得してきたデータを持つ
class PostLoaded extends PostState {
  // APIから取得してきたPostの配列
  final List<Post> posts;

  // 表示するデータが最大数に達したかどうかを持つフラグ
  final bool hasReachedMax;

  PostLoaded({
    this.posts,
    this.hasReachedMax
  }): super([posts, hasReachedMax]);

  // MARK: copyWith()
  // 0個以上のPostsを持つPostLoadedのインスタンスをコピーするメソッド
  PostLoaded copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts ,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => 'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}