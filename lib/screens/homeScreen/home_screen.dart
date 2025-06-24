import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kurf/screens/homeScreen/kite_size.dart';
import 'package:kurf/utils/colors.dart';

import '../../controllers/weatherController/weather_controller.dart';
import '../../utils/contstants.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());
    return Obx(() {
      final weather = weatherController.weather.value;
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 13, 19, 20),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 167, 232, 243),
                  Colors.white,
                ],
              ),
            ),
            child: weatherController.isLoading.isTrue
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SizedBox(width: 20),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.black,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "welcome back ${userModel.value!.name}",
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 80),
                      Icon(Icons.waves,
                          color: const Color.fromARGB(255, 53, 41, 41),
                          size: 80),
                      SizedBox(height: 10),
                      KiteSizeText(
                        windSpeedKmh: double.parse(
                            weather!.current!.windSpeed10m.toString()),
                        userWeight:
                            int.parse(userModel.value!.weight.toString()),
                      ),
                   
                      SizedBox(height: 10),
                      Text(
                        "wind speed: ${weather.current!.windSpeed10m.toString()} ${weather.hourlyUnits!.windSpeed10m.toString()}",
                        style: GoogleFonts.montserrat(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${weather.current!.temperature2m.toString()} ${weather.hourlyUnits!.temperature2m.toString()}",
                        style: GoogleFonts.montserrat(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        formatDateTime(weather.current!.time ?? "0"),
                        style: GoogleFonts.montserrat(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(
                          thickness: 1,
                          indent: 40,
                          endIndent: 40,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _WeatherInfo(
                                img: "assets/sun.png",
                                label: "Sunrise",
                                sunText: weatherController
                                    .sunriseSunset.value!.sunrise,
                              ),
                            ),
                            Expanded(
                              child: _WeatherInfo(
                                img: "assets/time.png",
                                label: "Sunset",
                                sunText: weatherController
                                    .sunriseSunset.value!.sunset,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _WeatherInfo(
                                img: "assets/humidity.png",
                                label: "Humidity",
                                sunText:
                                    "${weather.hourly!.relativeHumidity2m![0].toString()} %",
                              ),
                            ),
                            Expanded(
                              child: _WeatherInfo(
                                img: "assets/sun.png",
                                label: "Day Length",
                                sunText: weatherController
                                    .sunriseSunset.value!.dayLength,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}

class _WeatherInfo extends StatelessWidget {
  final String img;
  final String label;
  final String sunText;

  const _WeatherInfo(
      {required this.img, required this.label, required this.sunText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                img,
                height: 40,
              ),
              Column(
                children: [
                  Text(
                    label,
                    style: GoogleFonts.montserrat(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    sunText,
                    style: GoogleFonts.montserrat(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
