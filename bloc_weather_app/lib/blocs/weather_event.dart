import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// MARK: - WeatherEvent abstract
// Swiftで言うProtocol、抽象クラスになるので
// 継承させて実装する

abstract class WeatherEvent extends Equatable {

  // MARK: - Constructor
  // [props]がわからない、プロパティを初期化してる？
  WeatherEvent([List props = const []]) : super(props);
}

// MARK: - FetchWeather Event
// ユーザーが地域名を入力した時にdispatchされるEvent。
// 渡ってきた地域名を使ってAPIからWeatherのModelを取得する。

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather({
    @required this.city
  }) : assert(city != null),
        super([city]);
}

class RefreshWeather extends WeatherEvent {
  final String city;

  RefreshWeather({
    @required this.city
  }) : assert(city != null),
       super([city]);
}