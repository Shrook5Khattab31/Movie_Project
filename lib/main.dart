import 'package:flutter/material.dart';
import 'Features/OnBoarding/onboarding_one.dart'; // استدعاء صفحة OnboardingOne

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark(),
      home: const OnboardingOne(), // بداية التطبيق من أول صفحة Onboarding
    );
  }
}