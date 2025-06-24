import '../Model/sunrise_model.dart';
import '../Model/weather_model.dart';
import '../controllers/api_controller.dart';
import '../utils/contstants.dart';

class WeatherService extends BaseApi {
  String url = 'https://api.open-meteo.com/v1/forecast';
  Future<WeatherResponseModel?> getCurrentWeather() async {
    final query = {
      'latitude': locationData!.latitude.toString(),
      'longitude': locationData!.longitude.toString(),
      'current': 'temperature_2m,wind_speed_10m',
      'hourly': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
    };

    final response = await sendGet(url, query: query);
    if (response != null && response.statusCode == 200) {
      return WeatherResponseModel.fromJson(response.body);
    }
    return null;
  }

  Future<SunriseSunsetModel?> getSunriseSunset() async {
    final url = 'https://api.sunrisesunset.io/json';
    final query = {
      'lat': locationData!.latitude.toString(),
      'lng': locationData!.longitude.toString(),
    };

    final response = await sendGet(url, query: query);
    if (response != null && response.statusCode == 200) {
      return SunriseSunsetModel.fromJson(response.body);
    }
    return null;
  }

  Future<WeatherResponseModel?> getBeachWeather(String lat, String lng) async {
    final query = {
      'latitude': lat,
      'longitude': lng,
      'current': 'temperature_2m,wind_speed_10m',
      'hourly': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
    };

    final response = await sendGet(url, query: query);
    if (response != null && response.statusCode == 200) {
      return WeatherResponseModel.fromJson(response.body);
    }
    return null;
  }
}
