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
            height: MediaQuery.of(context).size.height / 3.0,
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          // 左の yyyy/mm/dd () のテキストの部分
          Expanded(
            child: Card(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('2018 '),
                    Text('12/30', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    Text(' (水)')
                  ],
                ),
              ),
            ),
          ),
          // 右の 天気関連の部分
          Expanded(
            child: Card(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // 上下に並んだ二つのテキスト
                    Column(
                      children: <Widget>[
                        Text('今日の天気', style: TextStyle(fontSize: 12.0)),
                        Text('晴れ時々曇り', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    // 天気のアイコン
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20.0,
                    )
                  ],
                ),
              ),
          ),
          ),
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
          // Expanded: 
          // 比率を指定して一杯一杯に表示できる
          Expanded(
            flex: 1,
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
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 64.0,
              color: Colors.grey[350],
              width: MediaQuery.of(context).size.width / 1.6,
              // Text maxlines, overflow:
              // Text の長さを 2 行に制限して、オーバーした時は ... にする
              child: Text(
                '今日は可燃ゴミの収集日ですよまさか不燃物を捨てる人はいませんよね？不燃物を捨ててしまった人にはペナルティがあります。',
                maxLines: 2,
                overflow: TextOverflow.ellipsis
              ),
            ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.location_on, color: Theme.of(context).primaryColorDark),
                    Text('周辺情報', style: TextStyle(fontSize: 12.0))
                  ],
                ),
                onPressed: () => {},
              ),
              OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.people, color: Theme.of(context).primaryColorDark),
                    Text('くらしマナー', style: TextStyle(fontSize: 12.0))
                  ],
                ),
                onPressed: () => {},
              ),
              OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.monetization_on, color: Theme.of(context).primaryColorDark),
                    Text('料金情報', style: TextStyle(fontSize: 12.0))
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