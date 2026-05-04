import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class EditEntryScreen extends StatefulWidget {
  final QueryDocumentSnapshot entry;

  const EditEntryScreen({super.key, required this.entry});

  @override
  State<EditEntryScreen> createState() => _EditEntryScreenState();
}

class _EditEntryScreenState extends State<EditEntryScreen> {
  final FirestoreService _firestore = FirestoreService();
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.entry['text']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Entry")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: textController,
              maxLines: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _firestore.updateEntry(
                  widget.entry.id,
                  textController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: const Text("Save Changes"),
            )
          ],
        ),
      ),
    );
  }
}

