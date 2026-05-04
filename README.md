🌱 MindBloom — Final Project Submission
Developer: Kayla Rumph
Course: CSC 3350 — Mobile App Development
Semester: Spring 2026
Team: Solo Developer (Undergraduate)

MindBloom is a personal wellness and journaling app built using Flutter and Firebase, featuring mood tracking, journal entries, profile management, and push notifications.

This README includes all required documentation for the final project submission.

🌿 1. App Overview
MindBloom helps users track their emotional well‑being through:

Daily mood logging

Journal entries

Profile customization

Insights and trends

Push notifications

Secure cloud sync across devices

The app uses four Firebase services:

Firebase Authentication

Cloud Firestore

Firebase Storage

Firebase Cloud Messaging (FCM)

🌿 2. Core Features
✔ Firebase Authentication
Email/password login

User‑scoped data paths

Secure session handling

✔ Firestore CRUD
Create, read, update, delete journal entries

Real‑time updates

Search filtering

✔ Firebase Storage
Profile photo upload

Download URL stored in Firestore

✔ Firebase Cloud Messaging
Token generation

Token stored in Firestore

Supports foreground/background notifications

🌿 3. Architecture Overview
MindBloom uses a service‑based architecture:

Code
lib/
 ├── screens/
 ├── services/
 │     ├── auth_service.dart
 │     ├── firestore_service.dart
 │     ├── storage_service.dart
 │     └── fcm_service.dart
 ├── widgets/
 ├── models/
 └── main.dart
Benefits:
Clear separation of concerns

Easy to maintain

Firebase logic isolated from UI

Scalable for future features

🌿 4. Firestore Schema (Final Implementation)
Code
users (collection)
 └── {uid} (document)
      ├── profile (document)
      │     ├── name
      │     ├── email
      │     └── photoUrl
      └── entries (subcollection)
            └── {entryId}
                  ├── title
                  ├── content
                  ├── mood
                  ├── timestamp
                  └── imageUrl (optional)
Why this structure?
Keeps user data isolated

Reduces read cost

Simplifies security rules

Scales cleanly

🌿 5. Firebase Services Summary
Authentication
Email/password

UID used for all Firestore paths

Firestore
Real‑time listeners

User‑scoped subcollections

Local search filtering

Storage
Profile photo upload

Download URL saved to Firestore

FCM
Token requested on startup

Token stored at /users/{uid}/fcmToken

Supports foreground/background delivery


🌿 6. Testing Evidence
✔ Offline behavior
Firestore write failure handled with SnackBar

Offline persistence enabled

✔ Error handling
Try/catch around Firestore writes

User feedback for failed uploads

✔ Performance
Entry list optimized to reduce rebuilds

🌿 7. Curated Questions (Selection Note)
I selected 13 curated questions across:

Implementation

Architecture

Testing

Firebase

Reflection

A separate Word document contains questions only, as required.

Answers are delivered verbally during the presentation.

🌿 8. Solo Developer Note
This project was completed independently.
All Firebase services, UI screens, architecture decisions, and debugging were performed by me.
Commit history reflects consistent work across the project timeline.

🌿 9. Build Instructions
To run the app:

Code
flutter pub get
flutter run
To build the release APK:

Code
flutter build apk --release
🌿 10. Reflection
Throughout this project, I learned how to integrate multiple Firebase services into a cohesive mobile application. The biggest challenge was managing Firestore data flow and ensuring real‑time updates without stale UI. I also learned how to structure a scalable Flutter architecture using services and clean navigation patterns.

If I restarted this project, I would design the data model and services layer first before building UI screens. This would reduce refactoring and improve maintainability.

🌿 11. License
This project is for academic use only.