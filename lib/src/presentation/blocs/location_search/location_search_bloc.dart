import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_man/core/models/result.dart';

import '../../../domain/entities/location.dart';
import '../../../domain/usecases/get_location_by_name.dart';
import '../../../domain/usecases/get_location_by_zip.dart';
import 'location_search_event.dart';
import 'location_search_state.dart';

class LocationSearchBloc extends Bloc<LocationSearchEvent, LocationSearchState> {
  final GetLocationByName getLocationByName;

  final GetLocationByZip getLocationByZip;

  LocationSearchBloc({
    required this.getLocationByName,
    required this.getLocationByZip,
  }) : super(LocationSearchInitial()) {
    on<LocationRequestByName>((event, emit) async {
      emit(LocationSearchLoading(name: event.name));

      final result = await getLocationByName(event.name);

      if (result is SuccessResult<List<Location>>) {
        emit(LocationSearchSucessul(result.data));
      }

      if (result is FailureResult<List<Location>>) {
        emit(LocationSearchFailed(result.exception));
      }
    });

    on<LocationRequestByZip>((event, emit) async {
      emit(LocationSearchLoading(name: event.zip));

      final result = await getLocationByZip(event.zip);

      if (result is SuccessResult<Location>) {
        emit(LocationSearchSucessul([result.data]));
      }

      if (result is FailureResult<Location>) {
        emit(LocationSearchFailed(result.exception));
      }
    });

    on<LocationSearchReset>((event, emit) async {
      emit(LocationSearchInitial());
    });
  }
}
