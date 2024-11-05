// main.dart
import 'package:flutter/material.dart';
import 'package:movie_app/providers/blog_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/providers/user_provider.dart'; // Import the UserProvider
import 'package:movie_app/ui/screens/main_screen.dart';
import 'package:movie_app/ui/screens/onboarding_screen.dart';
import 'package:movie_app/ui/screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
   providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()), // Add BlogProvider here
      ],
      child:const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Check if onboarding is complete
  Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_complete') ?? false;
  }

  // Check if the user is already logged in
  Future<bool> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _checkOnboardingStatus(),
        builder: (context, onboardingSnapshot) {
          // Show loading spinner while waiting
          if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          bool onboardingComplete = onboardingSnapshot.data ?? false;

          // Show login screen or main screen based on login status
          return onboardingComplete
              ? FutureBuilder<bool>(
                  future: _checkLoginStatus(),
                  builder: (context, loginSnapshot) {
                    if (loginSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    bool isLoggedIn = loginSnapshot.data ?? false;
                    return isLoggedIn ? const MainScreen() : const LoginScreen();
                  },
                )
              : const OnboardingScreen();
        },
      ),
    );
  }
}
