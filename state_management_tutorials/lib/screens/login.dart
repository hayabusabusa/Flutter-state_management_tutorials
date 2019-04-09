import 'package:flutter/material.dart';
import 'package:state_management_tutorials/models/cart.dart';
import 'package:scoped_model/scoped_model.dart';

/// ログイン画面
class MyLoginScreen extends StatelessWidget {
  /// "Enter" ボタンが押された時に実行されるメソッド
  void onLoginSubmit(BuildContext context) {
    // ここで UI はモデルの状態に依存しない。
    // モデルにアクセスするために ScopedModel.of でアクセスする。
    var cart = ScopedModel.of<CartModel>(context);

    // アクセスしたモデルのメソッドを実行。
    cart.clear();

    // カタログ画面へ遷移
    // この遷移だと ViewController.push っぽい遷移になる
    // 画面の左端スワイプは効かない
    Navigator.pushReplacementNamed(context, '/catalog');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcom', style: Theme.of(context).textTheme.display4,),

              // この辺の SizedBox は余白を作るために配置している
              // 本来は Card の UI を作るために使用
              SizedBox(height: 24),
              _LoginTextField(hintText: 'Login'),
              SizedBox(height: 12),
              _LoginTextField(hintText: 'Password', obscureText: true),
              SizedBox(height: 24),
              FlatButton(
                onPressed: () => onLoginSubmit(context),
                color: Colors.blue,
                child: Text('Enter'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  _LoginTextField({
    Key key,
    @required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText:  hintText,
        fillColor: Colors.black12
      ),
      obscureText: obscureText,
    );
  }
}