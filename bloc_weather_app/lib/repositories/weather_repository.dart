import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc_weather_app/models/models.dart';
import 'package:bloc_weather_app/repositories/weather_api_client.dart';

// MARK: - Repository
// RepositoryではAPIとの通信はDataProviderで行っているため、
// データがどこからきているのかは知らなくていい。
// API Client と依存していて、APIのコールのみ行う。

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({
    @required this.weatherApiClient
  }) : assert(weatherApiClient != null);

  // MARK: - getWeather()
  // 地域名を受け取って天気のモデルをAPIからコール、パースまで行って返す。
  // locationIdをAPIから受け取るのと、Weatherのレスポンスを受け取る2つのAPIのコールが
  // 行われている。await が2連続でも行けるのはすごい。APIコール以外の処理がないのでシンプル。
  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}