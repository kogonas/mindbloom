import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final textController = TextEditingController();
  String selectedMood = "🙂";

  final List<String> moods = ["😀", "🙂", "😐", "😕", "😢", "😡", "😴"];
  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Journal Entry")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text("Mood", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 15,
              children: moods.map((mood) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                  child: Text(
                    mood,
                    style: TextStyle(
                      fontSize: 40,
                      color: selectedMood == mood ? Colors.blue : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: textController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Write your thoughts...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await _firestore.saveEntry(
                  textController.text.trim(),
                  selectedMood,
                );
                Navigator.pop(context);
              },
              child: const Text("Save Entry"),
            )
          ],
        ),
      ),
    );
  }
}
