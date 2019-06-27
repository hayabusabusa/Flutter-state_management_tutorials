import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Animated extends StatefulWidget {
  _AnimatedState createState() => _AnimatedState();
}

// AnimatedWidget
// addListener() や setState() を自分で書かなくても
// リユースが可能なアニメーションをしてくれる
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({
    Key key,
    Animation<double> animation
  }): super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

class _AnimatedState extends State<Animated> with SingleTickerProviderStateMixin {
  Animation<double> animation; // Animation: アニメーションの状態を管理している
  AnimationController controller; // AnimationController: Animation を新しく生成したりする

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    // Tween にアニメーションの開始値と終了値を指定する
    // addListener() しなくても AnimationWidget がやってくれる
    animation = Tween<double>(begin: 0, end: 150).animate(controller);
    
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic'),
      ),
      // Animation を渡して Animation の値を使うようにする
      // あくまでアニメーションの開始は AnimationController が行う
      body: AnimatedLogo(animation: animation,)
    );
  }
}