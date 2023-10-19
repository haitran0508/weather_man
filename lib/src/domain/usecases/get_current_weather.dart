import 'package:weather_man/src/domain/entities/current_weather.dart';

import '../../../core/models/result.dart';
import '../repositories/network_repository.dart';

class GetCurrentWeather {
  final NetworkRepository repository;

  GetCurrentWeather(this.repository);

  Future<Result<CurrentWeatherParameter>> call(String lat, String lon) => repository.getCurrentWeather(lat, lon);
}
