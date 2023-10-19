import 'package:equatable/equatable.dart';

import '../../../domain/entities/location.dart';

abstract class LocationSearchState extends Equatable {}

class LocationSearchInitial extends LocationSearchState {
  @override
  List<Object?> get props => [];
}

class LocationSearchLoading extends LocationSearchState {
  final String zip;
  final String name;

  LocationSearchLoading({this.zip = '', this.name = ''});

  @override
  List<Object?> get props => [zip, name];
}

class LocationSearchSucessul extends LocationSearchState {
  final List<Location> locations;

  LocationSearchSucessul(this.locations);

  @override
  List<Object?> get props => [locations];
}

class LocationSearchFailed extends LocationSearchState {
  final Exception exception;

  LocationSearchFailed(this.exception);

  @override
  List<Object?> get props => [exception];
}
