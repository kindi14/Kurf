import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String name;
  final String email;
  final String weight;
  final DateTime? createdAt;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.weight,
    this.createdAt,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      weight: map['weight'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
