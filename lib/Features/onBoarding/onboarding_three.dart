import 'package:flutter/material.dart';

import '../../core/constants/appAssets.dart';
import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_btn.dart';
import '../../l10n/app_localizations.dart';
import 'onboarding_four.dart';
import 'onboarding_two.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.onboarding3,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.33,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.02,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.explore_all_genres,
                      style: AppStyles.bold24White,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      lang.discover_movies_every_genre,
                      style: AppStyles.reg16White,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CustomElevatedButton(
                      text: lang.next,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingFour(),
                          ),
                        );
                      },
                      textStyle: AppStyles.semiBold20Black,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingTwo(),
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
                          style: AppStyles.semiBold20Yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}