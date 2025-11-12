import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/Features/Home/tabs/profile_tap/update_profile.dart';
import 'package:movie_project/Features/auth/forgetPassword.dart';
import 'Features/Home/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_project/Features/Home/tabs/profile_tap/resetPassword.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'Features/onBoarding/onboarding_one.dart';
import 'package:movie_project/Features/auth/register_screen.dart';
import 'Features/auth/loginScreen.dart';
import 'core/routing/routeNames.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});
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
        AppRoutes.updateProfileScreen: (context)=> UpdateProfile(loginToken: '',),
        AppRoutes.register: (context)=>  RegisterScreen(),
      },
    );
  }
}