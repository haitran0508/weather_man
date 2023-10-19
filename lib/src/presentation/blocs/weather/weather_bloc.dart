import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_man/src/domain/entities/current_weather.dart';
import 'package:weather_man/src/domain/usecases/get_current_weather.dart';

import '../../../../core/models/result.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;

  WeatherBloc({
    required this.getCurrentWeather,
  }) : super(WeatherInitial()) {
    on<CurrentWeatherRequest>((event, emit) async {
      emit(WeatherLoading(event.lat, event.lon));

      final result = await getCurrentWeather(event.lat, event.lon);

      if (result is SuccessResult<CurrentWeatherParameter>) {
        emit(WeatherRequestedSuccessful(result.data));
      }

      if (result is FailureResult<CurrentWeatherParameter>) {
        emit(WeatherRequestedFailed(result.exception));
      }
    });
  }
}
