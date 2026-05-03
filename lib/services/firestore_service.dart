import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  // Create user document on first login
  Future<void> createUserDoc() async {
    await _db.collection('users').doc(uid).set({
      'createdAt': DateTime.now(),
    }, SetOptions(merge: true));
  }

  // Save mood
  Future<void> saveMood(String mood) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('moods')
        .add({
      'mood': mood,
      'timestamp': DateTime.now(),
    });
  }

  // Save journal entry
  Future<void> saveEntry(String text, String mood) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('entries')
        .add({
      'text': text,
      'mood': mood,
      'timestamp': DateTime.now(),
    });
  }
  
Future<String?> uploadImage(File file) async {
  try {
    final ref = FirebaseStorage.instance
        .ref()
        .child("users/$uid/images/${DateTime.now().millisecondsSinceEpoch}.jpg");

    await ref.putFile(file);
    return await ref.getDownloadURL();
  } catch (e) {
    return null;
  }
}

  // Get entries
  Stream<QuerySnapshot> getEntries() {
    return _db
        .collection('users')
        .doc(uid)
        .collection('entries')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
