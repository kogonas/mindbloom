import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Account Info",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            Text("Email: ${user?.email ?? 'Unknown'}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Text("User ID: ${user?.uid ?? 'Unknown'}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),

            SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeProvider.isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}
