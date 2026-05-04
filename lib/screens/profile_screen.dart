import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/storage_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    loadProfileImage();
  }

  Future<void> loadProfileImage() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    setState(() {
      profileImageUrl = doc.data()?["profileImage"];
    });
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    final file = File(picked.path);
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final url = await StorageService().uploadProfileImage(uid, file);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"profileImage": url});

    setState(() {
      profileImageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickAndUploadImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    profileImageUrl != null ? NetworkImage(profileImageUrl!) : null,
                child: profileImageUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),

            Text("Email: ${user?.email ?? 'Unknown'}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Text("User ID: ${user?.uid ?? 'Unknown'}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),

            SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeProvider.isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: const Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}
