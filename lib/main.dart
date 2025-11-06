import 'package:flutter/material.dart';
import 'Features/Home/home_screen.dart';
import 'Features/auth/loginScreen.dart';
import 'core/routing/routeNames.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.homeScreen,
        routes:{
          AppRoutes.login: (context)=>  LoginScreen(),
          AppRoutes.homeScreen: (context)=>  HomeScreen(),
    }
    );
  }
}