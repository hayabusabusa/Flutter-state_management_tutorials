import 'package:flutter/material.dart';

import 'package:old_app_me/screens/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Look At-me!'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      endDrawer: HomeDrawer(),
      body: ListView(
        children: <Widget>[
          Header(),
          Daily(),
          Notice(),
          VicinityPanels(),
          HelpPanels()
        ],
      ),
    );
  }
}

/// メインの画像を表示するヘッダーの部分
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset(
            'images/home.jpg',
            width: 800,
            height: 240,
            fit: BoxFit.fill,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            color: Colors.white.withAlpha(150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('GK RESIDENCE / 101'),
                Text('山田 太朗 様')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 日付と天気の表示部分
class Daily extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // 左の yyyy/mm/dd () のテキストの部分
          Container(
            child: Row(
              children: <Widget>[
                Text('2018 ', textAlign: TextAlign.start),
                Text('12/30', style: TextStyle(fontSize: 30.0)),
                Text(' (水)')
              ],
            ),
          ),
          // Separator
          VerticalDivider(color: Colors.blue[400]),
          // 右の 天気関連の部分
          Container(
            child: Row(
              children: <Widget>[
                // 上下に並んだ二つのテキスト
                Column(
                  children: <Widget>[
                    Text('今日の天気'),
                    Text('晴れ時々曇り')
                  ],
                ),
                Container(width: 8.0), // Space
                // 天気のアイコン
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/// お知らせの部分
class Notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          // テキストとボタン
          SizedBox(
            width: MediaQuery.of(context).size.width / 4.0,
            child: Column(
              children: <Widget>[
                Text('お知らせ', style: TextStyle(color: Theme.of(context).primaryColorDark)),
                RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  color: Theme.of(context).primaryColor,
                  child: Text('一覧へ', style: TextStyle(color: Colors.white)),
                  onPressed: () => {},
                )
              ],
            ),
          ),
          SizedBox(width: 8.0), // Space
          // お知らせの内容表示
          Container(
            padding: const EdgeInsets.all(8.0),
            height: 64.0,
            color: Colors.grey[350],
            width: MediaQuery.of(context).size.width / 1.6,
            child: Text('今日は可燃ゴミの収集日です。'),
          )
        ],
      ),
    );
  }
}

/// 公共サービス関連の部分
class VicinityPanels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ボーダー付きのボタンが三つ
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton(
                padding: const EdgeInsets.all(16.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Theme.of(context).primaryColorDark),
                    Text('周辺情報')
                  ],
                ),
                onPressed: () => {},
              ),
              OutlineButton(
                padding: const EdgeInsets.all(16.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.people, color: Theme.of(context).primaryColorDark),
                    Text('くらしマナー')
                  ],
                ),
                onPressed: () => {},
              ),
              OutlineButton(
                padding: const EdgeInsets.all(16.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.monetization_on, color: Theme.of(context).primaryColorDark),
                    Text('料金情報')
                  ],
                ),
                onPressed: () => {},
              )
            ],
          ),
          // 幅いっぱいのボタン
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
              color: Theme.of(context).primaryColor,
              child: Text('公共サービスの連絡先', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () => {},
            ),
          )
        ],
      ),
    );
  }
}

class HelpPanels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        children: <Widget>[
          Text('お悩み・お困りの時', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                color: Theme.of(context).primaryColor,
                child: Text('ご契約', style: TextStyle(color: Colors.white)),
                onPressed: () => {},
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                color: Theme.of(context).primaryColor,
                child: Text('お支払い', style: TextStyle(color: Colors.white)),
                onPressed: () => {},
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                color: Theme.of(context).primaryColor,
                child: Text('ご請求', style: TextStyle(color: Colors.white)),
                onPressed: () => {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                color: Theme.of(context).primaryColor,
                child: Text('電気・ガス', style: TextStyle(color: Colors.white)),
                onPressed: () => {},
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                color: Theme.of(context).primaryColor,
                child: Text('証明書', style: TextStyle(color: Colors.white)),
                onPressed: () => {},
              ),
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                color: Theme.of(context).primaryColor,
                child: Text('ご解約', style: TextStyle(color: Colors.white)),
                onPressed: () => {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}