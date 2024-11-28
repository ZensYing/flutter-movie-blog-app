// lib/ui/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:movie_app/ui/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Import the HomeScreen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> onboardingTexts = [
    "Watch movies in Virtual Reality",
    "Download and watch offline wherever you are",
    "Get personalized recommendations just for you"
  ];
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    // Navigate to MainScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/img/Background.png',
                fit: BoxFit.cover,
              ),
            ),
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingTexts.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Circular Avatar with Outer Ring
                            Container(
                              padding: const EdgeInsets.all(
                                  8.0), // Outer ring padding
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.pinkAccent,
                                    Colors.tealAccent
                                  ],
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 100, // Adjust the size as needed
                                backgroundImage:
                                    AssetImage('assets/img/Avatar.png'),
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Main Text
                            Text(
                              onboardingTexts[index],
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            // Subtitle Text
                            const Text(
                              "Download and watch offline\nwherever you are",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // Dots Indicator and Next/Back Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            List.generate(onboardingTexts.length, (dotIndex) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == dotIndex
                                  ? Colors.tealAccent
                                  : Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentPage > 0)
                            TextButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: const Text(
                                "Back",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          else
                            const SizedBox(
                                width: 60), // Placeholder for alignment

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.tealAccent,
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(color: Colors.tealAccent),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              if (_currentPage < onboardingTexts.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                _completeOnboarding();
                              }
                            },
                            child: Text(
                                _currentPage == onboardingTexts.length - 1
                                    ? "Get Started"
                                    : "Next"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
