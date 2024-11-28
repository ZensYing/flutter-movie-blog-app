import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'home_screen.dart';
import 'movie_screen.dart';
import 'blog_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Define the screens for each tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const MovieScreen(),
    const BlogScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the selected screen based on the current index
      body: _screens[_currentIndex],
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.black,
        waterDropColor: Colors.tealAccent,
        iconSize: 24,
        barItems: [
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
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
