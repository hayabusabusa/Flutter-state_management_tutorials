import 'package:flutter/material.dart';
import 'package:state_management_tutorials/models/cart.dart';
import 'package:state_management_tutorials/screens/login.dart';
import 'package:state_management_tutorials/screens/catalog.dart';
import 'package:state_management_tutorials/screens/cart.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // App status になる model を初期化
  final cart = CartModel();

  runApp(
    ScopedModel<CartModel>(
      model: cart,
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          display4: TextStyle(
            fontFamily: 'Corben',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.black
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyLoginScreen(),
        '/catalog': (context) => MyCatalog(),
        '/cart': (context) => MyCart(),
      },
    );
  }
}