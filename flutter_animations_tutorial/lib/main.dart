import 'package:flutter/material.dart';
import 'package:flutter_animations_tutorial/pages/home.dart';

void main() {
  runApp(AnimationTutorialApp());
}

class AnimationTutorialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animation_tutorial',
      home: Home(),
    );
  }
}
