import 'package:bloc_weather_app/repositories/weather_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/models/models.dart';
import 'package:bloc_weather_app/repositories/repositories.dart';
import 'package:bloc_weather_app/blocs/blocs.dart';

// MARK: - Bloc
// Blocは非常にシンプルで、
// EventをStateに変換して流していくだけ、
// Repositoryに依存している。

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  // MARK: - Repository
  // データのやり取りを行うRepositoryをプロパティとして持つ
  final WeatherRepository weatherRepository;

  WeatherBloc({
    @required this.weatherRepository
  }) : assert(weatherRepository != null);

  // MARK: - initialState
  // 初期状態のStateが必ず必要
  @override
  WeatherState get initialState => WeatherEmpty();

  // MARK: - mapEventToState
  // Blocのメイン機能であるEventをStateに変換する部分
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    
    // FetchのEventが流れてきたら
    if (event is FetchWeather) {

      // まずロード中のEventを流す
      yield WeatherLoading();

      try {
        // cityが取れる？ is で型がFetchWeatherに限定されているからっぽい
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}