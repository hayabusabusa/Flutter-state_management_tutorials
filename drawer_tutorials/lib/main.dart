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

// Add Drawer tutorials 
// Drawer(ドロワー)はサイドメニューみたいなUI、タブのスペースがない時に有効
// 使用するためには Scaffold Widget でラップする必要がある
class Page extends StatefulWidget {
  Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    // Drawer を使用するために Scaffold でラップ
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer tutorials'),
      ),
      drawer: Drawer(
        // もちろん中にコンテンツを入れることができる
        // ListView をコンテンツとして入れてみる
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer のヘッダー部分
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item1'),
              onTap: () {
                // Update the state of the app.
                // ...
                // タップ時に Drawer を閉じてみる
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item2'),
              onTap: () {
                // Update the state of the app.
                // ...
                // タップ時に Drawer を閉じてみる
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}