import 'package:equatable/equatable.dart';

abstract class LocationSearchEvent extends Equatable {}

class LocationRequestByName extends LocationSearchEvent {
  final String name;

  LocationRequestByName(this.name);

  @override
  List<Object?> get props => [name];
}

class LocationRequestByZip extends LocationSearchEvent {
  final String zip;

  LocationRequestByZip(this.zip);

  @override
  List<Object?> get props => [zip];
}

class LocationSearchReset extends LocationSearchEvent {
  @override
  List<Object?> get props => [];
}
