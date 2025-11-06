import 'package:flutter/material.dart';
import '../../core/constants/appAssets.dart';
import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../l10n/app_localizations.dart';
import '../auth/loginScreen.dart';
import 'onboarding_five.dart';

class OnboardingEnd extends StatelessWidget {
  const OnboardingEnd({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Image.asset(
              AppImages.onboardingEnd,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06, vertical: screenHeight * 0.03),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    lang.start_watching_now,
                    style: AppStyles.bold24White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomElevatedButton(
                    text: lang.finish,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    backgroundColor: AppColors.secondColor,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.secondColor,
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        lang.back,
                        style: AppStyles.bla14Yellow,
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