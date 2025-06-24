import 'package:get/get.dart';

import '../../Model/beach_model.dart';
import '../../services/weather_api_services.dart';
import '../api_controller.dart';

class BeachesController extends GetxController {
  final api = BaseApi();
  final beaches = <Beach>[].obs;
  RxBool isLoading = false.obs;
  BeachesController() {
    beaches.addAll([
      Beach(
          name: 'Qurum Beach',
          latitude: 23.614420,
          longitude: 58.455254,
          rating: 4.7),
      Beach(
          name: 'Al Sifah Beach',
          latitude: 23.418731,
          longitude: 58.789778,
          rating: 4),
      Beach(
          name: 'fins Beach',
          latitude: 22.846735,
          longitude: 59.240952,
          rating: 3.9),
      Beach(
          name: 'Al Shatti Beach',
          latitude: 23.614328,
          longitude: 58.545284,
          rating: 4.9),
      Beach(
          name: 'Mina Al Fahl Beach',
          latitude: 23.636389,
          longitude: 58.508888,
          rating: 4.5),
    ]);
  }

  Future<void> fetchWindSpeeds() async {
    isLoading.value = true;
    for (var beach in beaches) {
      final service = WeatherService();
      final result = await service.getBeachWeather(
          beach.latitude.toString(), beach.longitude.toString());
      if (result != null) {
        beach.windSpeed = result.current!.windSpeed10m!.toString() +
            result.currentUnits!.windSpeed10m!.toString();
      }
    }
    beaches.refresh();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchWindSpeeds();
  }
}
