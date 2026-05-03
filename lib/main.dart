import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/theme_provider.dart';

// Screens
import 'screens/splash_screen.dart';
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
import 'screens/edit_entry_screen.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),

      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,

      home: const SplashScreen(),

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
        "/mainNav": (_) => const MainNavigationScreen(),
      },
    );
  }
}
