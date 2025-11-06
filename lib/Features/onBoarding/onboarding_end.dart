import 'package:flutter/material.dart';
import 'package:movie_project/core/widgets/custom_elevated_button.dart';

import 'onboarding_five.dart'; // ✅ علشان زرار Back لو رجعنا

class OnboardingEnd extends StatelessWidget {
  const OnboardingEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🖼 الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding_end.jpg', // ✅ غيري اسم الصورة حسب الموجودة عندك
              fit: BoxFit.cover,
            ),
          ),

          // 🔲 المستطيل الكبير
          Positioned(
            top: 709, // ✅ حسب طلبك
            left: (MediaQuery.of(context).size.width - 430) / 2,
            child: Container(
              width: 430,
              height: 223,
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
                    'Start Watching Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  // 🔘 زرار Finish
                  CustomElevatedButton(
                    text: "Finish",
                    onPressed: () {
                      // ✅ هنا ممكن تضيفي التنقل للـ Login أو Home بعد ما تخلصي الـ Onboarding
                    },
                  ),

                  const SizedBox(height: 12),

                  // ⬛ زرار Back
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingFive(),
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
                          color: const Color(0xFFFFBB3B), // 🎨 اللون الأصفر الجديد
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