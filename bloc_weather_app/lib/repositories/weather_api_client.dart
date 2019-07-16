import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_weather_app/models/models.dart';

// MARK: - DataProvider
// API ClientはDataProvider層に当たるもの
// APIとのやりとりのみを行う。

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  // MARK: - Constructor
  // @required指定なので初期化時にないとエラーになる
  WeatherApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  // MARK: - getLocationId()
  // 地域名を引数として受け取り、それをAPIにリクエストして
  // 地域のIDを受け取る関数
  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponce = await this.httpClient.get(locationUrl);

    if (locationResponce.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final locationJson = jsonDecode(locationResponce.body) as List;
    return (locationJson.first)['woeid'];
  }

  // MARK: - fetchWeather()
  // 地域のIDを引数として受け取り、
  // それをパラメータとして天気のデータをレスポンスとしてもらう
  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponce = await this.httpClient.get(weatherUrl);

    if (weatherResponce.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponce.body);
    return Weather.fromJson(weatherJson);
  }
}