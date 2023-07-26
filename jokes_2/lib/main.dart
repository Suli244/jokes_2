import 'package:flutter/material.dart';
import 'HomP.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}



// 4) Массив должен сохраняться в shared_preferences
