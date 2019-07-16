import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_weather_app/models/models.dart';

// MARK: - State
// アプリケーションの状態を表す。
// 今回は以下の状態がある。
//
// ・WeatherEmpty
//   初期の状態で、ユーザーがまだ地域を入力していない状態。
// ・WeatherLoading
//   WeatherのモデルをAPIから取得中の状態
// ・WeatherLoaded
//   ユーザーが入力した地域のWeatherのモデルを取得することに成功した状態
// ・WeatherError
//   Weatherのモデルを取得に失敗した状態

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({
    @required this.weather
  }) : assert(weather != null),
       super([weather]);
}

class WeatherError extends WeatherState {}