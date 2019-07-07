import 'package:bloc_counter/blocs/counter_bloc.dart';
import 'package:bloc_counter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocCounterApp());
}

class BlocCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bloc_counter",

      // MARK: Bloc Provider を使ってページを作成
      // State の変更に応じてUIを再描画させるため　BlocProvider を使ってWidgetを作成
      home: BlocProvider<CounterBloc>(
        builder: (context) => CounterBloc(),
        child: Home(),
      ),
    );
  }
}