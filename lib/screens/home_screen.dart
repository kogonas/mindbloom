import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MindBloom"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to MindBloom 🌿",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  _buildCard(
                    context,
                    title: "Add Mood",
                    icon: Icons.mood,
                    route: "/mood",
                  ),
                  _buildCard(
                    context,
                    title: "New Journal Entry",
                    icon: Icons.edit,
                    route: "/newEntry",
                  ),
                  _buildCard(
                    context,
                    title: "View Entries",
                    icon: Icons.list,
                    route: "/entries",
                  ),
                  _buildCard(
                    context,
                    title: "Insights",
                    icon: Icons.insights,
                    route: "/insights",
                  ),
                  _buildCard(
                    context,
                    title: "Wellness Reminders",
                    icon: Icons.notifications,
                    route: "/reminders",
                  ),
                  _buildCard(
                    context,
                    title: "Profile",
                    icon: Icons.person,
                    route: "/profile",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required IconData icon, required String route}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.green),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
