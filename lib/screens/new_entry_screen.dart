import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firestore_service.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final textController = TextEditingController();
  String selectedMood = "🙂";
  File? selectedImage;

  final List<String> moods = ["😀", "🙂", "😐", "😕", "😢", "😡", "😴"];
  final FirestoreService _firestore = FirestoreService();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> saveEntry() async {
    String? imageUrl;

    if (selectedImage != null) {
      imageUrl = await _firestore.uploadImage(selectedImage!);
    }

    await _firestore.saveEntry(
      textController.text.trim(),
      selectedMood,
    );

    if (imageUrl != null) {
      await _firestore.saveEntry(
        textController.text.trim(),
        selectedMood,
      );
    }

    Navigator.pop(context);
  }

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

            if (selectedImage != null)
              Image.file(selectedImage!, height: 150),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Upload Image"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveEntry,
              child: const Text("Save Entry"),
            )
          ],
        ),
      ),
    );
  }
}
