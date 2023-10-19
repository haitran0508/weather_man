import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_man/src/presentation/widgets/weather_summary.dart';

import '../../../core/dependency_injection/dependency_injection.dart';
import '../blocs/location_search/location_search_bloc.dart';
import '../blocs/location_search/location_search_event.dart';
import '../blocs/location_search/location_search_state.dart';
import '../blocs/weather/weather_bloc.dart';
import '../blocs/weather/weather_event.dart';
import '../blocs/weather/weather_state.dart';
import '../constants/colors.dart';
import '../widgets/dual_segment.dart';

enum LocationSearchType { zip, name }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LocationSearchBloc _locationSearchBloc;
  late final WeatherBloc _weatherBloc;

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  Timer? _scheduledSearchRequest;

  LocationSearchType _locationSearchType = LocationSearchType.zip;

  bool _isSelectingLocation = false;

  @override
  void initState() {
    super.initState();
    _locationSearchBloc = getIt.get<LocationSearchBloc>();
    _weatherBloc = getIt.get<WeatherBloc>();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() => _isSelectingLocation = true);
      } else {
        setState(() => _isSelectingLocation = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DualSegmentSelection selection;
    switch (_locationSearchType) {
      case LocationSearchType.zip:
        selection = DualSegmentSelection.left;
        break;
      case LocationSearchType.name:
        selection = DualSegmentSelection.right;
        break;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 60,
          elevation: 0,
          title: const Text('Weather Man'),
          backgroundColor: AppColors.secondaryColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(33, 30, 33, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<WeatherBloc, WeatherState>(
                    bloc: _weatherBloc,
                    builder: (context, state) {
                      if (state is WeatherLoading) {
                        return const CircularProgressIndicator(
                          color: AppColors.secondaryColor,
                        );
                      }

                      if (state is WeatherRequestedSuccessful) {
                        final weather = state.weather;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: weather.cityName,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '  ${weather.country}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              weather.weatherDetail,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 15),
                            WeatherSummary(
                              temp: weather.temp,
                              realFeel: weather.feelLike,
                              tempMax: weather.tempMax,
                              tempMin: weather.tempMin,
                              humidity: weather.humidity,
                              wind: weather.windSpeed,
                              visibility: weather.visibility,
                              pressure: weather.pressure,
                            ),
                          ],
                        );
                      }

                      if (state is WeatherRequestedFailed) {
                        return const Text(
                          'Failed to fetch the weather condition with selected location.\nPlease try again later or contact our support.',
                        );
                      }

                      return const Text(
                        'Please enter zip or name of the place to get weather condition',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: AppColors.backgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              if (_isSelectingLocation)
                BlocBuilder<LocationSearchBloc, LocationSearchState>(
                    bloc: _locationSearchBloc,
                    builder: (context, state) {
                      if (state is LocationSearchLoading) {
                        return const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }

                      if (state is LocationSearchSucessul) {
                        if (state.locations.isEmpty) {
                          return const Text(
                            'Cannot find any matching location!\nPlease try again',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          );
                        }
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var location in state.locations) ...[
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _weatherBloc.add(
                                    CurrentWeatherRequest(location.lat, location.lon),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(33, 10, 33, 10),
                                  child: Text(
                                    location.fullForm,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 33),
                                child: Divider(
                                  color: Color(0xFF9399A2),
                                  thickness: 0.5,
                                ),
                              ),
                            ],
                          ],
                        );
                      }

                      if (state is LocationSearchFailed) {
                        return const Text(
                          'There are some issue during the searching.\n Please try again later or switch to zip or name to search',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        );
                      }

                      return const SizedBox.shrink();
                    }),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 50),
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Search location by zip or name...',
                    hintStyle: const TextStyle(fontSize: 13),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(13, 5, 13, 17),
                    suffix: DualSegment(
                      leftLabel: 'Zip',
                      rightLabel: 'Name',
                      selection: selection,
                      onSelectionChanged: _onSearchTypeChanged,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: _onLocationTextChange,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLocationTextChange(String value) {
    _scheduledSearchRequest?.cancel();

    if (value.isEmpty) {
      _locationSearchBloc.add(LocationSearchReset());
    } else {
      _scheduledSearchRequest = Timer(
        const Duration(seconds: 1),
        () => _requestLocation(_locationSearchType, value),
      );
    }
  }

  void _onSearchTypeChanged(DualSegmentSelection selection) {
    switch (selection) {
      case DualSegmentSelection.right:
        _locationSearchType = LocationSearchType.name;
        break;
      case DualSegmentSelection.left:
        _locationSearchType = LocationSearchType.zip;
        break;
    }

    _requestLocation(_locationSearchType, _textController.text);
  }

  void _requestLocation(LocationSearchType type, String value) {
    switch (type) {
      case LocationSearchType.name:
        _locationSearchBloc.add(LocationRequestByName(value));
        break;
      case LocationSearchType.zip:
        _locationSearchBloc.add(LocationRequestByZip(value));
        break;
    }
  }
}
