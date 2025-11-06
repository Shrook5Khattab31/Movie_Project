import 'package:flutter/material.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_elevated_button.dart';


import 'onboarding_two.dart'; // الصفحة التانية

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼 خلفية الصورة تملأ الشاشة بالكامل
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding1.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🖋 المحتوى فوق الصورة مع Gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  AppColors.primaryColor.withOpacity(0.85),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Find Your Next\nFavorite Movie Here',
                  style: AppStyles.bold24White,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Get access to a huge library of movies\nto suit all tastes. You will surely like it.',
                  style: AppStyles.reg16White,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomElevatedButton(
                  text: "Explore Now",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingTwo(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}