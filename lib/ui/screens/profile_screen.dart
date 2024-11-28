import 'package:flutter/material.dart';
import 'package:movie_app/ui/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'onboarding_screen.dart';
import 'about_app_screen.dart';
import 'policy_screen.dart';
import 'support_screen.dart';
import 'news_feature_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchAppVersion();
  }

  // Fetch the app version from package info
  Future<void> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  // Handle logout action
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_logged_in');

    // Clear user data from UserProvider
    Provider.of<UserProvider>(context, listen: false).clearUser();

    // Navigate to the onboarding screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  // Navigate to the login screen if user is not logged in
  Future<void> _goToLogin(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final bool? isLoggedIn =
        userProvider.isLoggedIn; // Get login status from UserProvider

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/img/home_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.9),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(userProvider.userAvatar),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => (isLoggedIn ?? false)
                      ? _logout(context)
                      : _goToLogin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.tealAccent),
                    ),
                  ),
                  child: Text(
                    (isLoggedIn ?? false) ? "Logout" : "Go Login",
                    style: const TextStyle(
                      color: Colors.tealAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(color: Colors.white54),
                ListTile(
                  leading: const Icon(Icons.policy, color: Colors.tealAccent),
                  title: const Text(
                    "Policy & Terms",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PolicyScreen()),
                    );
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.info_outline, color: Colors.tealAccent),
                  title: const Text(
                    "About App",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutAppScreen()),
                    );
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.support_agent, color: Colors.tealAccent),
                  title: const Text(
                    "Support",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportScreen()),
                    );
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.new_releases, color: Colors.tealAccent),
                  title: const Text(
                    "News Feature (Upcoming)",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsFeatureScreen()),
                    );
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.verified_user, color: Colors.tealAccent),
                  title: Text(
                    "App Version $_appVersion",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
