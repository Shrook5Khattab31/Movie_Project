import 'package:flutter/material.dart';
import 'package:movie_project/Features/auth/forgetPassword.dart';
import 'Features/Home/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_project/Features/Home/tabs/profile_tap/resetPassword.dart';
import 'l10n/app_localizations.dart';
import 'Features/onBoarding/onboarding_one.dart';
import 'Features/auth/loginScreen.dart';
import 'core/routing/routeNames.dart';

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

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      initialRoute: AppRoutes.onBoardingScreen,
      routes: {
        AppRoutes.onBoardingScreen: (context) => OnboardingOne(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.resetPassScreen: (context) => ResetPassword(),
        AppRoutes.homeScreen: (context) => HomeScreen(),
        AppRoutes.forgetPassScreen: (context)=> ForgetPasswordScreen(),
      },
    );
  }
}