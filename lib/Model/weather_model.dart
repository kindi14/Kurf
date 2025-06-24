class WeatherResponseModel {
  num? latitude;
  num? longitude;
  num? generationtimeMs;
  num? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  num? elevation;
  CurrentUnits? currentUnits;
  Current? current;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;

  WeatherResponseModel(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.currentUnits,
      this.current,
      this.hourlyUnits,
      this.hourly});

  WeatherResponseModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    generationtimeMs = json['generationtime_ms'];
    utcOffsetSeconds = json['utc_offset_seconds'];
    timezone = json['timezone'];
    timezoneAbbreviation = json['timezone_abbreviation'];
    elevation = json['elevation'];
    currentUnits = json['current_units'] != null
        ? CurrentUnits.fromJson(json['current_units'])
        : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    hourlyUnits = json['hourly_units'] != null
        ? HourlyUnits.fromJson(json['hourly_units'])
        : null;
    hourly = json['hourly'] != null ? Hourly.fromJson(json['hourly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['generationtime_ms'] = generationtimeMs;
    data['utc_offset_seconds'] = utcOffsetSeconds;
    data['timezone'] = timezone;
    data['timezone_abbreviation'] = timezoneAbbreviation;
    data['elevation'] = elevation;
    if (currentUnits != null) {
      data['current_units'] = currentUnits!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (hourlyUnits != null) {
      data['hourly_units'] = hourlyUnits!.toJson();
    }
    if (hourly != null) {
      data['hourly'] = hourly!.toJson();
    }
    return data;
  }
}

class CurrentUnits {
  String? time;
  String? interval;
  String? temperature2m;
  String? windSpeed10m;

  CurrentUnits(
      {this.time, this.interval, this.temperature2m, this.windSpeed10m});

  CurrentUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['interval'] = interval;
    data['temperature_2m'] = temperature2m;
    data['wind_speed_10m'] = windSpeed10m;
    return data;
  }
}

class Current {
  String? time;
  num? interval;
  num? temperature2m;
  num? windSpeed10m;

  Current({this.time, this.interval, this.temperature2m, this.windSpeed10m});

  Current.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    interval = json['interval'];
    temperature2m = json['temperature_2m'];
    windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['interval'] = interval;
    data['temperature_2m'] = temperature2m;
    data['wind_speed_10m'] = windSpeed10m;
    return data;
  }
}

class HourlyUnits {
  String? time;
  String? temperature2m;
  String? relativeHumidity2m;
  String? windSpeed10m;

  HourlyUnits(
      {this.time,
      this.temperature2m,
      this.relativeHumidity2m,
      this.windSpeed10m});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    temperature2m = json['temperature_2m'];
    relativeHumidity2m = json['relative_humidity_2m'];
    windSpeed10m = json['wind_speed_10m'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m'] = temperature2m;
    data['relative_humidity_2m'] = relativeHumidity2m;
    data['wind_speed_10m'] = windSpeed10m;
    return data;
  }
}

class Hourly {
  List<String>? time;
  List<num>? temperature2m;
  List<num>? relativeHumidity2m;
  List<num>? windSpeed10m;

  Hourly(
      {this.time,
      this.temperature2m,
      this.relativeHumidity2m,
      this.windSpeed10m});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    temperature2m = json['temperature_2m'].cast<double>();
    relativeHumidity2m = json['relative_humidity_2m'].cast<int>();
    windSpeed10m = json['wind_speed_10m'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m'] = temperature2m;
    data['relative_humidity_2m'] = relativeHumidity2m;
    data['wind_speed_10m'] = windSpeed10m;
    return data;
  }
}
