import 'package:flutter/material.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/features/auth/view/signup_view.dart';
import 'package:hungry/root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hungry',

      home: Root(),
    );
  }
}
