import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class MoodScreen extends StatelessWidget {
  MoodScreen({super.key});

  final FirestoreService _firestore = FirestoreService();

  final List<String> moods = ["😀", "🙂", "😐", "😕", "😢", "😡", "😴"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("How are you today?")),
      body: Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: moods.map((mood) {
            return GestureDetector(
              onTap: () async {
                await _firestore.saveMood(mood);
                Navigator.pop(context);
              },
              child: Text(
                mood,
                style: const TextStyle(fontSize: 50),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
