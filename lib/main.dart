import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/mood_screen.dart';
import 'screens/new_entry_screen.dart';
import 'screens/entry_list_screen.dart';
import 'screens/entry_detail_screen.dart';
import 'screens/insights_screen.dart';
import 'screens/reminders_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_entry_screen.dart'; // Needed for routing if you ever call it directly

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),

      // ALL ROUTES GO HERE
      routes: {
        "/login": (_) => const LoginScreen(),
        "/register": (_) => const RegisterScreen(),
        "/home": (_) => const HomeScreen(),
        "/mood": (_) => MoodScreen(),
        "/newEntry": (_) => const NewEntryScreen(),
        "/entries": (_) => EntryListScreen(),
        "/insights": (_) => InsightsScreen(),
        "/reminders": (_) => const RemindersScreen(),
        "/profile": (_) => const ProfileScreen(),
      },
    );
  }
}
