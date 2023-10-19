import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/config/app_config.dart';
import '../../../core/config/config_constants.dart';
import '../models/weather.dart';

class WeatherService {
  Future<CurrentWeather> fetchCurrentWeather(String lat, String lon) async {
    Map<String, String> queryParams = {
      'lat': lat,
      'lon': lon,
      'appid': AppConfig.instance.getValue(ConfigConstants.apiKey),
    };

    final uri = Uri(
      scheme: 'https',
      host: AppConfig.instance.getValue(ConfigConstants.host),
      path: AppConfig.instance.getValue(ConfigConstants.weatherPath),
      queryParameters: queryParams,
    );

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        return CurrentWeather.fromJson(result);
      } else {
        throw Exception([response.statusCode]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
