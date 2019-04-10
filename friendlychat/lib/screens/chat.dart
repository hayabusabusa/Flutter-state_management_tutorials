import 'package:flutter/material.dart';

import 'package:friendlychat/screens/chat_message.dart';

/// メインのチャットの画面
/// 
/// Stateful な Widget を表示するので Stateful Widget になる
class ChatScreen extends StatefulWidget {
  // createState() 関数をオーバーロードして State を追加
  @override
  State createState() => ChatScreenState();
}

/// チャット画面の State
/// 
/// アニメーションを利用するために [TrinckerProviderStateMixin] を含める
/// vsync で画面外のアニメーションが不要なリソースを消費するのを防ぐ
class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];

  // TextEditingController
  // 入力フィールドの内容の読み取り、テキストフィールドのクリアなどに使用
  final TextEditingController _textController = TextEditingController();

  /// アニメーションが不要になった時に実行される関数
  /// 
  /// 複数の画面があるアプリの場合画面が非表示になるとよばれて
  /// 不要になった [AnimationController] を解放してくれる
  @override
  void dispose() {
    for (ChatMessage messsage in _messages) {
      messsage.animationController.dispose();
    }
    super.dispose();
  }

  /// メッセージ送信時に実行される関数
  /// 
  /// リストに新規のメッセージを追加、テキストフィールドのクリアを行う
  void _handleSubmitted(String text) {
    _textController.clear();

    if(text.isNotEmpty) {
      ChatMessage message = ChatMessage(
        text: text,
        animationController: AnimationController(
          duration: Duration(milliseconds: 600),
          vsync: this
        ),
      );
      setState(() {
        _messages.insert(0, message);
      });
      message.animationController.forward();
    }
  }

  // Container Widget を返す
  // 設定済みの TextField も含まれている。
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        // 画面の両端から8.0ピクセルの余白を作る
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        // テキストフィールドとボタンは隣に並ぶので Row widget を使って行として並べる
        child: Row(
          children: [
            // Flexible widget を使うことで
            // 使っていない余白を使うようにサイズを自動で調整するようにできる
            Flexible(
              child: TextField(
               // TextEditingController を指定
               controller: _textController,
                // 定義しておいたコールバック関数を指定
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                 hintText: 'Send a message'
                ),
              ),
            ),
            // Container widget に入れることで
            // 余白を定義できるようになる
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendlychat'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }
}