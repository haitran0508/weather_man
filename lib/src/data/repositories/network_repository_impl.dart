import 'package:weather_man/src/data/services/weather_service.dart';
import 'package:weather_man/src/domain/entities/current_weather.dart';
import 'package:weather_man/src/domain/entities/location.dart';

import 'package:weather_man/core/models/result.dart';

import '../../domain/repositories/network_repository.dart';
import '../services/location_service.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final LocationService locationService;
  final WeatherService weatherService;

  NetworkRepositoryImpl({
    required this.locationService,
    required this.weatherService,
  });

  @override
  Future<Result<List<Location>>> getLocationByName(String name) async {
    try {
      final locationsResult = await locationService.fetchLocationByName(name);

      return Result.success<List<Location>>(
        locationsResult
            .map<Location>(
              (location) => Location(
                  name: location.name,
                  lat: location.lat.toString(),
                  lon: location.lon.toString(),
                  country: location.country,
                  state: location.state),
            )
            .toList(),
      );
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<Location>> getLocationByZip(String zip) async {
    try {
      final locationsResult = await locationService.fetchLocationByZip(zip);

      return Result.success(Location(
        name: locationsResult.name,
        lat: locationsResult.lat.toString(),
        lon: locationsResult.lon.toString(),
        country: locationsResult.country,
      ));
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<CurrentWeatherParameter>> getCurrentWeather(String lat, String lon) async {
    try {
      final weather = await weatherService.fetchCurrentWeather(lat, lon);

      const convertIndex = 273.15;

      return Result.success(CurrentWeatherParameter(
        weatherOverview: weather.weather[0].main,
        weatherDetail: weather.weather[0].description,
        temp: (weather.main.temp - convertIndex).round().toString(),
        feelLike: (weather.main.feelsLike - convertIndex).round().toString(),
        tempMax: (weather.main.tempMax - convertIndex).round().toString(),
        tempMin: (weather.main.tempMin - convertIndex).round().toString(),
        humidity: weather.main.humidity.round().toString(),
        windSpeed: weather.wind.speed.round().toString(),
        rain: (weather.rain?.the1H != null) ? weather.rain?.the1H?.round().toString() : null,
        snow: (weather.snow?.the1H != null) ? weather.snow?.the1H?.round().toString() : null,
        cityName: weather.name,
        country: weather.sys.country,
        visibility: weather.visibility.toString(),
        pressure: weather.main.pressure.toString(),
      ));
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
}
