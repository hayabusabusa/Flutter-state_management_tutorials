import 'dart:async';
import 'package:bloc_weather_app/blocs/blocs.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_weather_app/models/models.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  // MARK: - initialState

  @override
  ThemeState get initialState => ThemeState(
    theme: ThemeData.light(),
    color: Colors.lightBlue
  );

  // MARK: - mapEventToState

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is WeatherChanged) {
      yield _mapWeatherConditionToThemeData(event.condition);
    }
  }

  // WeatherConditionからThemeDataを作ってStateを返す
  ThemeState _mapWeatherConditionToThemeData(WeatherCondition condition) {
    ThemeState theme;

    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.orangeAccent,
          ),
          color: Colors.yellow,
        );
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.lightBlueAccent,
          ),
          color: Colors.lightBlue,
        );
        break;
      case WeatherCondition.heavyCloud:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.blueGrey,
          ),
          color: Colors.grey,
        );
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.indigoAccent,
          ),
          color: Colors.indigo,
        );
        break;
      case WeatherCondition.thunderstorm:
        theme = ThemeState(
          theme: ThemeData(
            primaryColor: Colors.deepPurpleAccent,
          ),
          color: Colors.deepPurple,
        );
        break;
      case WeatherCondition.unknown:
        theme = ThemeState(
          theme: ThemeData.light(),
          color: Colors.lightBlue,
        );
        break;
    }
    return theme;
  }
}