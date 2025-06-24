import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

class EquipmentDetailScreen extends StatefulWidget {
  final String name;
  final double pricePerHour;
  final String image;

  const EquipmentDetailScreen({
    super.key,
    required this.name,
    required this.pricePerHour,
    required this.image,
  });

  @override
  State<EquipmentDetailScreen> createState() => _EquipmentDetailScreenState();
}

class _EquipmentDetailScreenState extends State<EquipmentDetailScreen> {
  int _rentalHours = 1;

  double get totalPrice => widget.pricePerHour * _rentalHours;

  void _proceedToPayment() {
    Get.defaultDialog(
      title: "Payment",
      content: Column(
        children: [
          Text("You rented: ${widget.name}"),
          Text("For $_rentalHours hours"),
          Text("Total: OMR${totalPrice.toStringAsFixed(2)}"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.snackbar("Success", "Payment processed");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text("Confirm Payment"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F6F9),
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(widget.image, height: 150),
            const SizedBox(height: 20),
            Text("Price: OMR${widget.pricePerHour}/hour",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Select hours:",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                Text("$_rentalHours hrs",
                    style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ],
            ),
            Slider(
              value: _rentalHours.toDouble(),
              min: 1,
              max: 24,
              divisions: 23,
              label: '$_rentalHours',
              onChanged: (value) {
                setState(() {
                  _rentalHours = value.toInt();
                });
              },
            ),
            const SizedBox(height: 20),
            Text("Total: OMR${totalPrice.toStringAsFixed(2)}",
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            ElevatedButton(
              onPressed: _proceedToPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Proceed to Payment", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
