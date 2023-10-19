import 'package:get_it/get_it.dart';
import 'package:weather_man/src/data/repositories/network_repository_impl.dart';
import 'package:weather_man/src/data/services/weather_service.dart';
import 'package:weather_man/src/domain/usecases/get_current_weather.dart';
import 'package:weather_man/src/domain/usecases/get_location_by_name.dart';
import 'package:weather_man/src/presentation/blocs/location_search/location_search_bloc.dart';
import 'package:weather_man/src/presentation/blocs/weather/weather_bloc.dart';

import '../../src/data/services/location_service.dart';
import '../../src/domain/repositories/network_repository.dart';
import '../../src/domain/usecases/get_location_by_zip.dart';

final getIt = GetIt.instance;

void dependencyRegister() {
  getIt.registerLazySingleton<LocationService>(() => LocationService());

  getIt.registerLazySingleton<WeatherService>(() => WeatherService());

  getIt.registerLazySingleton<NetworkRepository>(
    () => NetworkRepositoryImpl(
      locationService: getIt.get<LocationService>(),
      weatherService: getIt.get<WeatherService>(),
    ),
  );

  getIt.registerLazySingleton<GetLocationByName>(
    () => GetLocationByName(
      getIt.get<NetworkRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetLocationByZip>(
    () => GetLocationByZip(
      getIt.get<NetworkRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetCurrentWeather>(
    () => GetCurrentWeather(
      getIt.get<NetworkRepository>(),
    ),
  );

  getIt.registerLazySingleton<LocationSearchBloc>(
    () => LocationSearchBloc(
      getLocationByName: getIt.get<GetLocationByName>(),
      getLocationByZip: getIt.get<GetLocationByZip>(),
    ),
  );

  getIt.registerLazySingleton<WeatherBloc>(
    () => WeatherBloc(
      getCurrentWeather: getIt.get<GetCurrentWeather>(),
    ),
  );
}
