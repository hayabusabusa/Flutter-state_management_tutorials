import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_weather_app/models/models.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super(props);
}

// MARK: - WeatherChanged Event
// Weatherのconditionに応じてテーマカラーを変更する
class WeatherChanged extends ThemeEvent {
  final WeatherCondition condition;

  WeatherChanged({
    @required this.condition
  }) : assert(condition != null),
       super([condition]);
}