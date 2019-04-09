import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // 全体に適応されるテーマの定義
      // アプリ全体でここで定義したテーマの設定が使える
      theme: ThemeData(
        // デフォルトの輝度と色を定義
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // フォントを定義
        fontFamily: 'Montserrat',

        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind')
        )
      ),
      home: MyHomePage(title: 'Title'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({
    Key key,
    @required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Text(
            'Text with a background color.',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      // 特定の Widget に別のテーマを適応させる
      // MaterialApp で定義したテーマを拡張して適応させる
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.lightBlueAccent),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}