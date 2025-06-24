import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/auth_controllers.dart';
import '../../utils/colors.dart';
import '../../utils/validator.dart';
import '../widgets/kurf_btn_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  final TextEditingController weightController = TextEditingController();
  bool isLoading = false;
  bool agreeToTerms = false;
  bool obscurePassword = true;
  bool obscureRetypePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Text("Let's",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 30)),
                  Text("Create",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold)),
                  Text("Your\nAccount",
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(nameController, "Full Name", Icons.person),
                    const SizedBox(height: 15),
                    _buildTextField(
                        emailController, "Email Address", Icons.email),
                    const SizedBox(height: 15),
                    _buildWeightField(
                        weightController, "Weight (kg)", Icons.monitor_weight),
                    const SizedBox(height: 15),
                    _buildPasswordField(passwordController, "Password", true),
                    const SizedBox(height: 15),
                    _buildPasswordField(
                        retypePasswordController, "Retype Password", false),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: agreeToTerms,
                          onChanged: (val) =>
                              setState(() => agreeToTerms = val ?? false),
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'I agree to the ',
                              children: [
                                TextSpan(
                                  text: 'Terms & Privacy',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    KurfButton(
                      text: 'Sign Up',
                      isLoading: isLoading,
                      onPressed: () async {
                        if (_formKey.currentState!.validate() && agreeToTerms) {
                          setState(() => isLoading = true);
                          await AuthController.instance.register(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text,
                            weight: weightController.text.trim(),
                          );
                          setState(() => isLoading = false);
                        }
                      },
                      bgColor: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have an account? "),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text("Sign In",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
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

  Widget _buildPasswordField(
      TextEditingController controller, String hint, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? obscurePassword : obscureRetypePassword,
      validator: (value) {
        if (isPassword) return Validator.passwordValidator(value);
        return Validator.confirmPasswordValidator(
            passwordController.text, value);
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            (isPassword ? obscurePassword : obscureRetypePassword)
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              if (isPassword) {
                obscurePassword = !obscurePassword;
              } else {
                obscureRetypePassword = !obscureRetypePassword;
              }
            });
          },
        ),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
