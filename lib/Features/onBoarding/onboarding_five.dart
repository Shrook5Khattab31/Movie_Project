import 'package:flutter/material.dart';
import 'package:movie_project/core/widgets/custom_elevated_button.dart';

import 'onboarding_four.dart';
import 'onboarding_end.dart'; // ✅ استيراد صفحة النهاية

class OnboardingFive extends StatelessWidget {
  const OnboardingFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼 الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding5.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🔲 المستطيل الكبير
          Positioned(
            top: 600,
            left: (MediaQuery.of(context).size.width - 430) / 2,
            child: Container(
              width: 430,
              height: 321,
              decoration: const BoxDecoration(
                color: Color(0xFF121312),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Rate,Review,and Learn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Share your thoughts on the movies\nyou ve watched. Dive deep into\nfilm details and help others discover\ngreat movies with your reviews.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  // 🔘 زرار Next → يفتح OnboardingEnd
                  CustomElevatedButton(
                    text: "Next",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingEnd(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),

                  // ⬛ زرار Back
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingFour(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF121312),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFFBB3B),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          color: Color(0xFFFFBB3B),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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