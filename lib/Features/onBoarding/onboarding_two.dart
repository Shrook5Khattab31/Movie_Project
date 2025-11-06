import 'package:flutter/material.dart';
import '../../core/constants/appAssets.dart';
import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_btn.dart';
import '../../l10n/app_localizations.dart';
import 'onboarding_three.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final lang = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Image.asset(
              AppImages.onboarding2,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06, vertical: screenHeight * 0.03),
              color: AppColors.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    lang.discover_movies,
                    style: AppStyles.bold24White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    lang.explore_vast_collection,
                    style: AppStyles.reg16White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: lang.next,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OnboardingThree()),
                        );
                      },
                      backgroundColor: AppColors.secondColor,
                      textColor: AppColors.primaryColor,
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