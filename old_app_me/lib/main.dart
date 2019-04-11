import 'package:flutter/material.dart';

import 'package:old_app_me/screens/home.dart';

void main() {
  runApp(OldAppMeApp());
}

class OldAppMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Look At-me!',
      theme: ThemeData(
        // Colors
        primaryColor: Color.fromARGB(255, 26, 188, 156), // rgb(26, 188, 156)
        primaryColorDark: Color.fromARGB(255, 22, 160, 133), // rgb(22, 160, 133)

        // Fonts
        primaryTextTheme: TextTheme(
          title: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey),
          body1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey[300])
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen()
      },
    );
  }
}