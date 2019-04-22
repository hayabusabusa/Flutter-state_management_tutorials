import 'package:flutter/material.dart';

import 'package:text_input_tutorial/screens/home.dart';

void main() {
  runApp(TextInputTutorialApp());
}

class TextInputTutorialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TextInputTutorial",
      theme: ThemeData(
        // Color
        primaryColor: Colors.blue,

        // Font
        primaryTextTheme: TextTheme(
          title: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)
        )
      ),
      home: HomeScreen(),
    );
  }
}