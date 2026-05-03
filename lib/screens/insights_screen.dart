import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class InsightsScreen extends StatelessWidget {
  InsightsScreen({super.key});

  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Insights")),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(_firestore.uid)
            .collection('moods')
            .orderBy('timestamp', descending: true)
            .limit(7)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final moods = snapshot.data!.docs;

          if (moods.isEmpty) {
            return const Center(child: Text("No mood data yet"));
          }

          // Extract mood emojis
          final moodList = moods.map((doc) => doc['mood'] as String).toList();

          // Count frequency
          final Map<String, int> freq = {};
          for (var m in moodList) {
            freq[m] = (freq[m] ?? 0) + 1;
          }

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("7‑Day Mood Trend",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(moodList.join("  "), style: const TextStyle(fontSize: 32)),

                const SizedBox(height: 30),

                const Text("Mood Frequency",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: freq.entries.map((e) {
                    return Text("${e.key}  x${e.value}",
                        style: const TextStyle(fontSize: 18));
                  }).toList(),
                ),

                const SizedBox(height: 30),

                const Text("Suggested Wellness Actions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("• Try a 5‑minute breathing exercise"),
                const Text("• Journal before bed tonight"),
                const Text("• Take a short walk outside"),
              ],
            ),
          );
        },
      ),
    );
  }
}
