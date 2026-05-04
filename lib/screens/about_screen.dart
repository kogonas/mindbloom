import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About MindBloom")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "MindBloom",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            Text(
              "MindBloom is a personal wellness journal designed to help you track your moods, write daily reflections, and gain insights into your emotional patterns.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            Text(
              "Developed by Kayla Rumph",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            Text(
              "This app was created as part of the CSC3350 Software Development course.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
