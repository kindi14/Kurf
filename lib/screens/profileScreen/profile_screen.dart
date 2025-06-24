import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/validator.dart';
import '../loginScreen/login_screen.dart';
import '../widgets/kurf_btn_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch the current user's information from Firebase
  void _fetchUserData() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          var data = doc.data()!;
          nameController.text = data['name'] ?? '';
          emailController.text = data['email'] ?? '';
          weightController.text = data['weight'] ?? '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 50),
                      SizedBox(width: 15),
                      Text("Profile",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                            nameController, "Full Name", Icons.person),
                        const SizedBox(height: 15),
                        _buildTextField(
                            emailController, "Email Address", Icons.email),
                        const SizedBox(height: 15),
                        _buildWeightField(weightController, "Weight (kg)",
                            Icons.monitor_weight),
                        const SizedBox(height: 20),
                        KurfButton(
                          text: 'Update',
                          isLoading: isLoading,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              var user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .update({
                                  'name': nameController.text.trim(),
                                  'email': emailController.text.trim(),
                                  'weight': weightController.text.trim(),
                                });

                                Get.snackbar(
                                    "Success", "Profile updated successfully",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                              setState(() => isLoading = false);
                            }
                          },
                          bgColor: AppColors.primaryColor,
                        ),
                        const SizedBox(height: 30),
                        KurfButton(
                          text: 'Logout',
                          isLoading: isLoading,
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              Get.offAll(() => const LoginScreen());
                              Get.snackbar("Success", "Logged out successfully",
                                  snackPosition: SnackPosition.BOTTOM);
                            } catch (e) {
                              Get.snackbar("Error",
                                  "An error occurred while logging out",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          bgColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (hint == "Full Name") return Validator.nameValidator(value);
        if (hint == "Email Address") return Validator.emailValidator(value);
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  Widget _buildWeightField(
      TextEditingController controller, String hint, IconData icon) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: Validator.weightValidator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
