import 'package:equatable/equatable.dart';

class CurrentWeatherParameter extends Equatable {
  final String weatherOverview;
  final String weatherDetail;
  final String temp;
  final String feelLike;
  final String tempMin;
  final String tempMax;
  final String humidity;
  final String windSpeed;
  final String? rain;
  final String? snow;
  final String cityName;
  final String country;
  final String visibility;
  final String pressure;

  const CurrentWeatherParameter({
    required this.weatherOverview,
    required this.weatherDetail,
    required this.temp,
    required this.feelLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.rain,
    required this.snow,
    required this.cityName,
    required this.country,
    required this.visibility,
    required this.pressure,
  });

  @override
  List<Object?> get props => [
        weatherOverview,
        weatherDetail,
        temp,
        feelLike,
        tempMin,
        tempMax,
        humidity,
        windSpeed,
        rain,
        snow,
        cityName,
        country,
        pressure,
        visibility
      ];
}
