import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_infinite_list/blocs/bloc.dart';
import 'package:bloc_infinite_list/screens/home.dart';

void main() {
  runApp(BlocInfiniteListApp());
}

class BlocInfiniteListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite list',
      home: BlocProvider(
        builder: (context) => PostBloc(httpClient: http.Client())..dispatch(Fetch()),
        child: Home(),
      ),
    );
  }
}