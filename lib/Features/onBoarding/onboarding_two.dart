import 'package:flutter/material.dart';
import 'package:movie_project/core/widgets/custom_elevated_button.dart';

import 'onboarding_three.dart'; // ✅ استيراد الصفحة التالتة

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼 الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding2.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🔲 المستطيل السفلي بالمحتوى
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 430,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFF121312), // اللون الغامق
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Discover Movies',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Explore a vast collection of movies in all\nqualities and genres. Find your next\nfavorite film with ease.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                    text: "Next",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingThree(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}