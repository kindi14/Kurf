import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kurf/utils/contstants.dart';

import '../../Model/beach_model.dart';
import '../../utils/colors.dart';
import '../widgets/kurf_btn_widget.dart';

class RateBeachScreen extends StatefulWidget {
  final Beach beach;

  const RateBeachScreen({super.key, required this.beach});

  @override
  State<RateBeachScreen> createState() => _RateBeachScreenState();
}

class _RateBeachScreenState extends State<RateBeachScreen> {
  double selectedRating = 0;
  final TextEditingController commentController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text("Rate",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 30)),
                  Text(widget.beach.name,
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Rating", style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating = (index + 1).toDouble();
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: commentController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Write a comment (optional)",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  KurfButton(
                    text: 'Submit',
                    isLoading: isLoading,
                    bgColor: AppColors.primaryColor,
                    onPressed: () async {
                      if (selectedRating == 0) {
                        Get.snackbar("Error", "Please select a rating.");
                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      await FirebaseFirestore.instance
                          .collection('beach_ratings')
                          .add({
                        'userId': userModel.value!.uid,
                        'beachName': widget.beach.name,
                        'rating': selectedRating,
                        'comment': commentController.text.trim(),
                        'timestamp': FieldValue.serverTimestamp(),
                      });

                      setState(() {
                        isLoading = false;
                      });

                      Get.back();
                      Get.snackbar("Success", "Thank you for rating!");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
