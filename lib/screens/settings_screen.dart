import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'about_screen.dart';
import '../providers/theme_provider.dart';
import 'profile_screen.dart';
import 'reminders_screen.dart';
import 'insights_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Reminders"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RemindersScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.insights),
            title: const Text("Insights"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InsightsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
            },  
          ),


          SwitchListTile(
            title: const Text("Dark Mode"),
            value: themeProvider.isDark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("App Version"),
            subtitle: Text("1.0.0"),
          ),
        ],
      ),
    );
  }
}
