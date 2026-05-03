import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot entry;

  const EntryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Entry Detail")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mood: ${entry['mood']}", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(entry['text'], style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
