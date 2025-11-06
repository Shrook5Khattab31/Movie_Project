import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => LoginScreen(),
        '/onboarding': (context) => const OnboardingOne(),
      },
    );
  }
}