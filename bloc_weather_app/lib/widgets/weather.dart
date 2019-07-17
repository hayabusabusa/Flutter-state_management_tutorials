import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_weather_app/blocs/blocs.dart';
import 'package:bloc_weather_app/widgets/widgets.dart';

class Weather extends StatefulWidget {
  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  // Completer を扱うためStatefulWidgetにする
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {

    // 型指定してBlocProviderからBlocを取り出し
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),

            // ここにもasyncがかけるとは
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );

              if (city != null) {
                weatherBloc.dispatch(FetchWeather(city: city));
              }
            },
          ),
        ],
      ),
      body: Center(

        // MARK: - BlocListener
        // 指定したBlocに変更があった場合はlistenerに通知される
        // listener内ではStateがロード完了だった場合に
        // BlocProviderでThemeBlocを取り出してdispatchしている

        child: BlocListener(
          bloc: weatherBloc, // どのBlocを購読するか
          listener: (BuildContext context, WeatherState state) {
            if (state is WeatherLoaded) {
              BlocProvider.of<ThemeBloc>(context).dispatch(
                WeatherChanged(condition: state.weather.condition),
              );

              // RefreshCotrollerを完了にする
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          child: BlocBuilder(
            bloc: weatherBloc,
            builder: (_, WeatherState state) {

              // StateがWeatherEmptyの時
              if (state is WeatherEmpty) {
                return Center(child: Text('Please Select a Location'),);
              }

              // StateがWeatherLoadingの時
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator(),);
              }

              // StateがWeatherLoadedの時
              if (state is WeatherLoaded) {
                final weather = state.weather;

                return BlocBuilder(
                  bloc: BlocProvider.of<ThemeBloc>(context),
                  builder: (_, ThemeState themeState) {
                    return GradientContainer(
                      color: themeState.color,
                      child: RefreshIndicator(
                        onRefresh: () {
                          weatherBloc.dispatch(
                            RefreshWeather(city: state.weather.location)
                          );
                          return _refreshCompleter.future;
                        },
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Center(
                                child: Location(location: weather.location,),
                              ),
                            ),
                            Center(
                              child: LastUpdated(dateTime: weather.lastUpdated,),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Center(
                                child: CombinedWeatherTemperature(weather: weather,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              // StateがWeatherErrorの時
              if (state is WeatherError) {
                return Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}