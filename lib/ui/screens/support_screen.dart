// lib/ui/screens/support_screen.dart
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
        backgroundColor: const Color.fromARGB(255, 6, 196, 187),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text(
              "Contact Support",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent,
              ),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.phone, color: Colors.tealAccent),
              title: Text(
                "Tel: 069284356",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          const  ListTile(
              leading: Icon(Icons.email, color: Colors.tealAccent),
              title: Text(
                "Email: sounsoratha@gmail.com",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          const  ListTile(
              leading: Icon(Icons.location_on, color: Colors.tealAccent),
              title: Text(
                "Location: Phnom Penh, Terk Tla, Sensok",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "For any inquiries, feel free to reach out to us. We're here to help with any questions or support you may need regarding the Movie & Blog App.",
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
