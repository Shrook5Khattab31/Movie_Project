import 'package:flutter/material.dart';
import 'package:movie_project/Features/auth/register_screen.dart';

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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.register,
        routes:{
          AppRoutes.login: (context)=>  LoginScreen(),
          AppRoutes.register: (context)=>  RegisterScreen(),
        }
    );
  }
}