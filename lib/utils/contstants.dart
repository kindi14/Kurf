import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../Model/user_data_model.dart';
import '../controllers/auth_controllers.dart';
import '../firebase_options.dart';

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
LocationData? locationData;
final Rx<AppUser?> userModel = Rx<AppUser?>(null);

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
String formatDateTime(String isoTime) {
  final dateTime = DateTime.parse(isoTime);
  final dayName = DateFormat('EEEE').format(dateTime);
  final day = dateTime.day;
  final time = DateFormat('h:mm a').format(dateTime);
  return "$dayName $day - $time";
}

Future<void> getUSerLocation() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locationData = await location.getLocation();
}
