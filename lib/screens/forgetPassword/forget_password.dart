import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = const Color(0xFF0097A7); // Teal blue background
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.white, width: 1.5),
    );
    final TextEditingController emailController = TextEditingController();

    // Reset password functionality
    Future<void> resetPassword() async {
      String email = emailController.text.trim();

      if (email.isEmpty) {
        Get.snackbar("Error", "Please enter your email address",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Get.snackbar("Success", "Password reset email sent successfully",
            snackPosition: SnackPosition.BOTTOM);
        Navigator.pop(context);
      } catch (e) {
        Get.snackbar("Error", "An error occurred: $e",
            snackPosition: SnackPosition.BOTTOM);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Icon(Iconsax.lock,
              size: 80, color: Color.fromARGB(221, 26, 29, 46)),
          const SizedBox(height: 20),
          Text(
            "Forgot\nPassword?",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "No worries, we’ll send you\nreset instructions",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: Colors.white),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "Reset Password",
                        style:
                            GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Back to Login",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Colors.white, // Set underline color to white
                          ),
                        )),
                  ),
                  const Center(
                    child: Icon(Iconsax.back_square,
                        color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
