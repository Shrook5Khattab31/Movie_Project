import 'package:flutter/material.dart';
import '../../core/constants/appAssets.dart';
import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../l10n/app_localizations.dart';
import 'onboarding_four.dart';
import 'onboarding_end.dart';

class OnboardingFive extends StatelessWidget {
  const OnboardingFive({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.onboarding5,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 430,
              height: screenHeight * 0.38,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    lang.rate_review_learn,
                    style: AppStyles.bold24White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    lang.share_your_thoughts,
                    style: AppStyles.reg16White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  CustomElevatedButton(
                    text: lang.next,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingEnd(),
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
                          builder: (context) => const OnboardingFour(),
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