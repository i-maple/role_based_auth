import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:role_based_auth/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    const MaterialApp(
      home: LoginScreen(),
    ),
  );
}
