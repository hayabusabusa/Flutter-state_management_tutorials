import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Basic extends StatefulWidget {
  _BasicState createState() => _BasicState();
}

class _BasicState extends State<Basic> with SingleTickerProviderStateMixin {
  Animation<double> animation; // Animation: アニメーションの状態を管理している
  AnimationController controller; // AnimationController: Animation を新しく生成したりする

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    // Tween にアニメーションの開始値と終了値を指定する
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // AddListener は setState() を呼ぶ
          // AnimationController は常に新しい値の Animation を生成するので、
          // その新しい値を反映するために build() が呼ばれる
        });
      });
    
    // アニメーションの開始
    controller.forward();
  }

  @override
  void dispose() {
    // Controller系は必ず解放する
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          // 高さ、幅をアニメーションさせる Animation の値を使う
          height: animation.value,
          width: animation.value,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}