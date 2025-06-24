import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import 'equipment_detail_screen.dart';

// Sample equipment model (you’ll later fetch this from Firebase or controller)
class Equipment {
  final String name;
  final String price;
  final String image;

  Equipment({required this.name, required this.price, required this.image});
}

class RentalScreen extends StatelessWidget {
  RentalScreen({super.key});

  final List<Equipment> equipmentList = [
    Equipment(
      name: 'Kite',
      price: '15 OMR/hour',
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIiibg46JqzBjzZPHMh4BMuMC8SPD7r15_FQ&s',
    ),
    Equipment(
      name: 'Board',
      price: '10 OMR/hour',
      image: 'https://www.tantrumkitesurf.com/wp-content/uploads/2017/06/kitesurf-board.jpg',
    ),
    Equipment(
      name: 'Helmet',
      price: '5 OMR/hour',
      image: 'https://www.kitemana.com/en-dk/_images/h537/mk8-helmet-286118.jpg',
    ),
    Equipment(
      name: 'Life Jacket',
      price: '5 OMR/hour',
      image: 'https://www.kingofwatersports.com/dam/jcr:aca438cb-ea39-4e48-823a-e9d7fe768d5f/mystic-foil-kite-impact-vest-2024-cutout-listing.jpg',
    ),
    Equipment(
      name: 'Harness',
      price: '8 OMR/hour',
      image: 'https://www.kingofwatersports.com/dam/jcr:99b0c42b-cf01-457e-bd24-a7b829801ab3/mystic-majestic-x-kite-wave-harness-black-alt1-zoom.jpg',
    ),
  ];

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
                  Icon(Icons.shopping_bag, size: 40),
                  SizedBox(width: 12),
                  Text(
                    "Rent Equipment",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: equipmentList.length,
                  itemBuilder: (context, index) {
                    final item = equipmentList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D2845),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              item.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1.2)),
                                  const SizedBox(height: 8),
                                  Text('Price: ${item.price}',
                                      style: const TextStyle(
                                          color: Colors.white70)),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(() => EquipmentDetailScreen(
                                  name: item.name,
                                  pricePerHour: double.parse(item.price.split(' ').first),
                                  image: item.image,
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              child: const Text("Rent"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
