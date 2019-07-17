import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/blocs/blocs.dart';
import 'package:bloc_weather_app/repositories/repositories.dart';
import 'package:bloc_weather_app/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  // Delegateを初期化
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Repositoryを初期化
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
      ),
    );

  // App(最上層)にThemeBlocを適応
  runApp(
    BlocProvider<ThemeBloc>(
      builder: (context) => ThemeBloc(),
      child: WeatherApp(weatherRepository: weatherRepository,),
    )
  );
}

class WeatherApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  WeatherApp({
    Key key,
    @required this.weatherRepository
  }) : assert(weatherRepository != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      // BlocProvider.ofで取り出し
      bloc: BlocProvider.of<ThemeBloc>(context),
      builder: (_, ThemeState themeState) {
        return MaterialApp(
          title: 'Bloc Weahter',

          // Stateから取り出したThemeDataを使用
          theme: themeState.theme,
          home: BlocProvider(
            builder: (context) => 
              WeatherBloc(weatherRepository: weatherRepository),
            child: Weather(),
          ),
        );
      },
    );
  }
}

// MARK: BlocDelegate
// Stateの遷移を可視化する？

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}