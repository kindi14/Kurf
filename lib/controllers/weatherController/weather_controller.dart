import 'package:get/get.dart';

import '../../Model/sunrise_model.dart';
import '../../Model/weather_model.dart';
import '../../services/weather_api_services.dart';

class WeatherController extends GetxController {
  final weather = Rxn<WeatherResponseModel>();
  RxBool isLoading = true.obs;
  final sunriseSunset = Rxn<SunriseSunsetModel>();
  @override
  void onInit() {
    super.onInit();
    fetchWeather();
  }
  Future<void> fetchWeather() async {
    isLoading.value = true;
    final service = WeatherService();
    final result = await service.getCurrentWeather();
    if (result != null) {
      weather.value = result;
      final sunData = await service.getSunriseSunset();
      if (sunData != null) {
        sunriseSunset.value = sunData;
      }
      isLoading.value = false;
    }
  }
}
