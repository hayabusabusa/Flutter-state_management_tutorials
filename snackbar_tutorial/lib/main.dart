import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

// SnackBar
// Drawer の時と同じように Scaffold でラップする
class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SnackBar Demo'),
      ),
      // SnackBar
      body: SnackBarPage(),
    );
  }
}

// SnackBar Page
// ボタンを押すと SnackBar が表示される Scaffold の中身を作る
class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Show SnackBar'),
        onPressed: () {
          // SnackBar を生成
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // SnackBar を押した時の処理
              },
            ),
          );

          // SnackBar を表示
          // Widget tree から表示するのに使う SnackBar を探す
          Scaffold.of(context).showSnackBar(snackBar);
        },
      ),
    );
  }
}