import 'package:equatable/equatable.dart';
import 'package:weather_man/src/domain/entities/current_weather.dart';

abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {
  final String lat;
  final String lon;

  WeatherLoading(this.lat, this.lon);

  @override
  List<Object?> get props => [lat, lon];
}

class WeatherRequestedSuccessful extends WeatherState {
  final CurrentWeatherParameter weather;

  WeatherRequestedSuccessful(this.weather);

  @override
  List<Object?> get props => [weather];
}

class WeatherRequestedFailed extends WeatherState {
  final Exception exception;

  WeatherRequestedFailed(this.exception);

  @override
  List<Object?> get props => [exception];
}
