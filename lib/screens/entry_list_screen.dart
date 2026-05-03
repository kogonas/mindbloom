import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import 'entry_detail_screen.dart';

class EntryListScreen extends StatelessWidget {
  EntryListScreen({super.key});

  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Entries")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.getEntries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data!.docs;

          if (entries.isEmpty) {
            return const Center(child: Text("No entries yet"));
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              final mood = entry['mood'];
              final text = entry['text'];

              return ListTile(
                leading: Text(mood, style: const TextStyle(fontSize: 30)),
                title: Text(text),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EntryDetailScreen(entry: entry),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
