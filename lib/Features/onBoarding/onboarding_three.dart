import 'package:flutter/material.dart';
import '../../core/constants/appAssets.dart';
import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../l10n/app_localizations.dart';
import 'onboarding_two.dart';
import 'onboarding_four.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

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
              AppImages.onboarding3,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenHeight * 0.025),
              color: AppColors.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: lang.next,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingFour(),
                          ),
                        );
                      },
                      backgroundColor: AppColors.secondColor,
                      textColor: AppColors.primaryColor,
                    ),
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