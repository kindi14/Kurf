class SunriseSunsetModel {
  final String date;
  final String sunrise;
  final String sunset;
  final String firstLight;
  final String lastLight;
  final String dawn;
  final String dusk;
  final String solarNoon;
  final String goldenHour;
  final String dayLength;
  final String timezone;
  final num utcOffset;

  SunriseSunsetModel({
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.firstLight,
    required this.lastLight,
    required this.dawn,
    required this.dusk,
    required this.solarNoon,
    required this.goldenHour,
    required this.dayLength,
    required this.timezone,
    required this.utcOffset,
  });

  factory SunriseSunsetModel.fromJson(Map<String, dynamic> json) {
    final data = json['results'];
    return SunriseSunsetModel(
      date: data['date'],
      sunrise: data['sunrise'],
      sunset: data['sunset'],
      firstLight: data['first_light'],
      lastLight: data['last_light'],
      dawn: data['dawn'],
      dusk: data['dusk'],
      solarNoon: data['solar_noon'],
      goldenHour: data['golden_hour'],
      dayLength: data['day_length'],
      timezone: data['timezone'],
      utcOffset: data['utc_offset'],
    );
  }
}
