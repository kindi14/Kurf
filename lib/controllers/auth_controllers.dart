import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kurf/screens/loginScreen/login_screen.dart';

import '../Model/user_data_model.dart';
import '../screens/bottomBar/bottom_bar.dart';
import '../utils/contstants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseUser.bindStream(FirebaseAuth.instance.userChanges());
    ever(firebaseUser, _setInitialScreen);

    _setInitialScreen(firebaseUser.value);
  }

  Future<void> _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      await _loadUserModel(user.uid);
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<void> _loadUserModel(String uid) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        userModel.value = AppUser.fromMap(doc.data()!);
      }
    } catch (e) {
      print("Failed to load user model: $e");
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String weight,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'weight': weight,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Get.snackbar("Success", "Account created successfully",
            snackPosition: SnackPosition.BOTTOM);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user == null) {
        Get.snackbar("Error", "User not found",
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      await _loadUserModel(user.uid);

      Get.snackbar("Success", "Logged in successfully",
          snackPosition: SnackPosition.BOTTOM);

      Get.off(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? "An error occurred",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
