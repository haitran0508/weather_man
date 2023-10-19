import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class CurrentWeatherRequest extends WeatherEvent {
  final String lat;
  final String lon;

  CurrentWeatherRequest(this.lat, this.lon);

  @override
  List<Object?> get props => [lat, lon];
}
