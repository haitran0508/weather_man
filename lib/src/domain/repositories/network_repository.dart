import 'package:weather_man/src/domain/entities/current_weather.dart';

import '../../../core/models/result.dart';
import '../entities/location.dart';

abstract class NetworkRepository {
  Future<Result<List<Location>>> getLocationByName(String name);
  Future<Result<Location>> getLocationByZip(String zip);
  Future<Result<CurrentWeatherParameter>> getCurrentWeather(String lat, String lon);
}
