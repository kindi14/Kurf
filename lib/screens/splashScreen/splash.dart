import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurf/utils/contstants.dart';

import '../../controllers/auth_controllers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigate();
    });
    super.initState();
  }

  Navigate() async {
    await getUSerLocation().then((value) {
      Get.put(AuthController(), permanent: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.waves, color: Colors.white, size: 80),
                SizedBox(height: 20),
                const Text(
                  "Kurf",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your kitesurf guide",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          )),
    );
  }
}
