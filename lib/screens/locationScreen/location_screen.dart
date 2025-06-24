import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurf/screens/locationScreen/rate_beach.dart';

import '../../controllers/beacher_controller/beach_controller.dart';
import '../../utils/colors.dart';

class BeachesScreen extends StatelessWidget {
  BeachesScreen({super.key});
  final BeachesController controller = Get.put(BeachesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F6F9),
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 50),
                  SizedBox(width: 15),
                  Text("Nearby Locations",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() => controller.isLoading.isTrue
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.beaches.length,
                        itemBuilder: (context, index) {
                          final beach = controller.beaches[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => RateBeachScreen(beach: beach));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0E2A47),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(beach.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                letterSpacing: 1.5)),
                                        Column(
                                          children: [
                                            Text(beach.windSpeed,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                            const SizedBox(height: 10),
                                            Row(
                                              children:
                                                  List.generate(5, (index) {
                                                if (index <
                                                    beach.rating.floor()) {
                                                  return const Icon(Icons.star,
                                                      color: Colors.amber,
                                                      size: 20);
                                                } else if (index <
                                                    beach.rating) {
                                                  return const Icon(
                                                      Icons.star_half,
                                                      color: Colors.amber,
                                                      size: 20);
                                                } else {
                                                  return const Icon(
                                                      Icons.star_border,
                                                      color: Colors.amber,
                                                      size: 20);
                                                }
                                              }),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
