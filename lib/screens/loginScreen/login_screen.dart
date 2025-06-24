import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kurf/screens/signup/signup_scree.dart';

import '../../controllers/auth_controllers.dart';
import '../../utils/colors.dart';
import '../../utils/validator.dart';
import '../forgetPassword/forget_password.dart';
import '../widgets/kuraf_input_widget.dart';
import '../widgets/kurf_btn_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5A5A5A), Color(0xFF0E1915)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.waves, color: Colors.white, size: 80),
                      SizedBox(height: 20),
                      Text(
                        'KURF',
                        style: GoogleFonts.montserrat(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          textStyle: TextStyle(
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        'WIND IN STYLE',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          textStyle: TextStyle(
                            letterSpacing: .1,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: KurfInputField(
                            controller: emailController,
                            hintText: 'Email or Phone',
                            icon: Icons.person,
                            validator: Validator.emailValidator,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: KurfInputField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            validator: Validator.passwordValidator,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ForgotPasswordScreen());
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 40),
                      KurfButton(
                        text: 'Login',
                        isLoading: isLoading,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => isLoading = true);
                            await AuthController.instance.login(
                              emailController.text.trim(),
                              passwordController.text,
                            );
                            setState(() => isLoading = false);
                          }
                        },
                        bgColor: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 10),
                      const Text('or', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      KurfButton(
                        text: 'Create an account',
                        onPressed: () {
                          Get.to(() => SignUpScreen());
                        },
                        bgColor: AppColors.primaryColor,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
