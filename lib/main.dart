import 'package:flutter/material.dart';
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
      title: 'Hungry App',
      theme: ThemeData(dialogBackgroundColor: Colors.white),
      home: Root(),
    );
  }
}
