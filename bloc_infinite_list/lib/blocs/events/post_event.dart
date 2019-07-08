import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {}

// MARK: Post event
// 今回リストが一番下までスクロールされた際に
// 新しいデータをフェッチしてくるだけ
class Fetch extends PostEvent {
  @override
  String toString() => 'Fetch';
}