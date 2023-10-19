class SearchedByZipLocation {
  final String zip;
  final String name;
  final double lat;
  final double lon;
  final String country;

  SearchedByZipLocation({
    required this.zip,
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory SearchedByZipLocation.fromJson(Map<String, dynamic> json) => SearchedByZipLocation(
        zip: json["zip"],
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "zip": zip,
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
      };
}
