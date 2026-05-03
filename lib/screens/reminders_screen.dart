import 'package:flutter/material.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool journalReminder = false;
  bool moodReminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wellness Reminders")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Journaling Reminder"),
              value: journalReminder,
              onChanged: (v) {
                setState(() => journalReminder = v);
              },
            ),
            SwitchListTile(
              title: const Text("Mood Check‑In"),
              value: moodReminder,
              onChanged: (v) {
                setState(() => moodReminder = v);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Settings saved")),
                );
              },
              child: const Text("Save Settings"),
            )
          ],
        ),
      ),
    );
  }
}
