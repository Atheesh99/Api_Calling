import 'package:api_call/screen/home_screen.dart';
import 'package:api_call/screen/home_user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MYApp());
}

class MYApp extends StatelessWidget {
  const MYApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeUserScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
