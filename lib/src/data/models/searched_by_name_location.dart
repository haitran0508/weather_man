class SearchedByNameLocation {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String? state;

  SearchedByNameLocation({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    this.state,
  });

  factory SearchedByNameLocation.fromJson(Map<String, dynamic> json) => SearchedByNameLocation(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}
