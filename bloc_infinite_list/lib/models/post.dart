import 'package:equatable/equatable.dart';

// MARK: Equtable
// Equtableを継承する
// これでPostのインスタンス同士を比較することができるようになる
class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  Post({
    this.id,
    this.title,
    this.body
  }) : super([id, title, body]) ;

  // MARK: ToString
  // これをオーバーライドすることでカスタムの文字列を返すことができるようになる
  @override
  String toString() => 'Post { id: $id }';
}