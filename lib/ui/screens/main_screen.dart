// lib/ui/screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'home_screen.dart';
import 'movie_screen.dart';
import 'blog_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String? username;
  String? email;
  bool isLoading = true; // Add a loading flag
  List<Widget> _screens = []; // Define screens as an empty list initially

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the screen initializes
  }

  Future<void> _fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('user_name') ?? 'Default User';
      email = prefs.getString('user_email') ?? 'default@example.com';
      isLoading = false; // Set loading to false once data is fetched

      // Initialize _screens after fetching user data
      _screens = [
        const HomeScreen(),
        const MovieScreen(),
        const BlogScreen(),
        const ProfileScreen(), // Use correct parameter names here
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator until user data is loaded
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: _screens[_currentIndex], // Display the selected screen
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.black, // Background color of the nav bar
        waterDropColor:
            Colors.tealAccent, // The color of the water drop animation
        iconSize: 24, // Icon size in the nav bar
        barItems: <BarItem>[
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
            filledIcon: Icons.movie,
            outlinedIcon: Icons.movie_outlined,
          ),
          BarItem(
            filledIcon: Icons.article,
            outlinedIcon: Icons.article_outlined,
          ),
          BarItem(
            filledIcon: Icons.person,
            outlinedIcon: Icons.person_outline,
          ),
        ],
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index; // Update the current index to switch screens
          });
        },
      ),
    );
  }
}
