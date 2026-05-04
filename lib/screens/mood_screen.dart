import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MoodScreen extends StatefulWidget {
  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> with SingleTickerProviderStateMixin {
  String? selectedMood;

  final List<String> moods = ["😀", "🙂", "😐", "😕", "😢"];

  Future<void> saveMood() async {
    if (selectedMood == null) return;

    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("moods")
        .add({
      "mood": selectedMood,
      "timestamp": Timestamp.now(),
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("How are you feeling?")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Animated Mood Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: moods.map((mood) {
                final isSelected = selectedMood == mood;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.withOpacity(0.2) : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: AnimatedScale(
                      scale: isSelected ? 1.4 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        mood,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 60),

            ElevatedButton(
              onPressed: saveMood,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                "Save Mood",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
