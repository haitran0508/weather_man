import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/config/app_config.dart';
import '../../../core/config/config_constants.dart';
import '../models/searched_by_name_location.dart';
import '../models/searched_by_zip_location.dart';

class LocationService {
  Future<List<SearchedByNameLocation>> fetchLocationByName(String name) async {
    Map<String, String> queryParams = {
      'q': name,
      'limit': '5',
      'appid': '3ed0ef21dd370431bc47b7f67e06aca3',
    };

    final uri = Uri(
      scheme: 'https',
      host: AppConfig.instance.getValue(ConfigConstants.host),
      path: AppConfig.instance.getValue(ConfigConstants.geocodingNamePath),
      queryParameters: queryParams,
    );

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        final List result = json.decode(response.body);

        return result
            .map<SearchedByNameLocation>(
              (element) => SearchedByNameLocation.fromJson(element),
            )
            .toList();
      } else {
        throw Exception([response.statusCode]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchedByZipLocation> fetchLocationByZip(String zip) async {
    Map<String, String> queryParams = {
      'zip': zip,
      'appid': '3ed0ef21dd370431bc47b7f67e06aca3',
    };

    final uri = Uri(
      scheme: 'https',
      host: AppConfig.instance.getValue(ConfigConstants.host),
      path: AppConfig.instance.getValue(ConfigConstants.geocodingZipPath),
      queryParameters: queryParams,
    );

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        return SearchedByZipLocation.fromJson(result);
      } else {
        throw Exception([response.statusCode]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
