class Beach {
  final String name;
  final double latitude;
  final double longitude;
  String windSpeed;
  double rating;

  Beach({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.windSpeed = "0.0 km/h",
    this.rating = 0.0,
  });
}
