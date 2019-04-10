import 'package:flutter/material.dart';

import 'package:friendlychat/screens/chat.dart';

void main() {
  runApp(FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friendlychat",
      initialRoute: '/',
      routes: {
        '/': (context) => ChatScreen(),
      }
    );
  }
}