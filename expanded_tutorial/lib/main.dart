import 'package:flutter/material.dart';

import 'package:expanded_tutorial/home.dart';

void main() {
  runApp(
    ExpandedTutorialApp()
  );
}

class ExpandedTutorialApp extends StatelessWidget {
  @override
  Widget build(BuildContext cotext) {
    return MaterialApp(
      title: "Expanded tutorial",
      theme: ThemeData(
        primaryTextTheme: TextTheme(title: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))
      ),
      home: HomeScreen(),
    );
  }
}