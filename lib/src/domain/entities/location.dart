import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String name;
  final String lat;
  final String lon;
  final String country;
  final String? state;
  final String? zip;

  String get fullForm => '$name,${(state != null) ? ' $state,' : ''} $country${(zip != null) ? ' $zip' : ''}';

  const Location({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
    this.zip,
  });

  @override
  List<Object?> get props => [name, lat, lon, country, zip];
}
