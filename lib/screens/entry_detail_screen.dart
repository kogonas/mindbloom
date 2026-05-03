import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import 'edit_entry_screen.dart';

class EntryDetailScreen extends StatelessWidget {
  final QueryDocumentSnapshot entry;

  EntryDetailScreen({super.key, required this.entry});

  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Entry Detail")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mood: ${entry['mood']}",
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(entry['text'], style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditEntryScreen(entry: entry),
                      ),
                    );
                  },
                  child: const Text("Edit"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    await _firestore.deleteEntry(entry.id);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
