import 'package:flutter/material.dart';

import '../homeScreen/home_screen.dart';
import '../locationScreen/location_screen.dart';
import '../profileScreen/profile_screen.dart';
import '../rentalScreen/rental_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    BeachesScreen(),
    MainHomeScreen(),
    RentalScreen(),
    UpdateProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed, // ✅ Required for 4+ items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, size: 34),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 38),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, size: 32), // ✅ New icon for Rental
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 34),
            label: '',
          ),
        ],
      ),
    );
  }
}
