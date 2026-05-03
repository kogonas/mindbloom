import 'package:flutter/material.dart';
import '../services/notification_service.dart';

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
              title: const Text("Daily Journaling Reminder (8:00 PM)"),
              value: journalReminder,
              onChanged: (v) async {
                setState(() => journalReminder = v);

                if (v) {
                  await NotificationService.scheduleDailyNotification(
                    id: 1,
                    title: "MindBloom",
                    body: "Take a moment to journal your thoughts today 🌿",
                    hour: 20,
                    minute: 0,
                  );
                }
              },
            ),

            SwitchListTile(
              title: const Text("Daily Mood Check-In (9:00 AM)"),
              value: moodReminder,
              onChanged: (v) async {
                setState(() => moodReminder = v);

                if (v) {
                  await NotificationService.scheduleDailyNotification(
                    id: 2,
                    title: "MindBloom",
                    body: "How are you feeling today?",
                    hour: 9,
                    minute: 0,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
