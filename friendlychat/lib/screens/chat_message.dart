import 'package:flutter/material.dart';

/// チャットのリストに表示するメッセージ
/// 
/// UITableViewCell みたいな構成になっている
class ChatMessage extends StatelessWidget {
  final String _name = 'Your Name';
  final String text;

  // AnimationController:
  // アニメーションがどのように実行されるかを指定する
  final AnimationController animationController;

  // コンストラクタ
  ChatMessage({
    this.text,
    this.animationController
  });

  @override
  Widget build(BuildContext context) {
    // SizeTransition: 
    // アニメーション
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController, curve: Curves.easeOut
      ),
      axisAlignment: 0.0,
      // Container: 
      // 全体に上下10ピクセルの余白を作るために 
      // Container Widget でラップ
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        // Row:
        // 基本的に全ての要素は横に並ぶので
        // Row Widget でラップして作っていく
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container:
            // アバターの部分
            // crossAxisAlignment: 親に対して相対的に配置
            // 親が Row Widget になるので主軸は水平 .start は垂直軸の一番高い位置になる
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
            // Column:
            // 名前とメッセージの内容の部分
            // 縦に並ぶので Column Widget でラップ
            // crossAxisAlignment: 親に対して相対的に配置
            // 親が Column Widget になるので主軸は 垂直 .start は水平軸の一番左の位置になる
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 上に表示する送信者の名前はメッセージのテキストよりも大きくする
                // なので Theme を適応させてテキストのスタイルを変更する
                Text(_name, style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}