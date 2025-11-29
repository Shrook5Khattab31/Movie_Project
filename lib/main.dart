import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_project/Features/Home/tabs/profile_tap/resetPassword.dart';
import 'package:movie_project/Features/Home/tabs/profile_tap/update_profile.dart';
import 'package:movie_project/Features/auth/forget_pass.dart';
import 'package:movie_project/Features/auth/register_screen.dart';
import 'package:movie_project/Features/moveDetails/movieDetails.dart';
import 'package:movie_project/core/theme/appTheme.dart';
import 'package:movie_project/provider/langProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/Home/home_screen.dart';
import 'Features/auth/loginScreen.dart';
import 'Features/onBoarding/onboarding_one.dart';
import 'core/routing/routeNames.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  final token = prefs.getString('authToken');
  final loginType = prefs.getString('loginType');

  Widget startScreen;
  if (!hasSeenOnboarding) {
    startScreen = OnboardingOne();
  } else if (token != null && loginType != null) {
    startScreen = HomeScreen(args: token, loginType: loginType);
  } else {
    startScreen = LoginScreen();
  }
  runApp(
      ChangeNotifierProvider(create: (context) => LangProvider(),
        child: MovieApp(startScreen: startScreen),
      )
  );
}

class MovieApp extends StatelessWidget {
  final Widget startScreen;

  const MovieApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LangProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: DarkAppTheme.darkTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: startScreen,
      routes: {
        AppRoutes.onBoardingScreen: (context) => OnboardingOne(),
        AppRoutes.login: (context) => LoginScreen(),
        AppRoutes.resetPassScreen: (context) => ResetPassword(),
        AppRoutes.homeScreen: (context) {
          final token = ModalRoute.of(context)?.settings.arguments as String?;
          return HomeScreen(args: token);
        },
        AppRoutes.forgetPassScreen: (context) => ForgetPasswordScreen(),
        AppRoutes.updateProfileScreen: (context) => UpdateProfile(),
        AppRoutes.register: (context) => RegisterScreen(),
        AppRoutes.detailsScreen:(context)=>MovieDetails()
      },
      locale: Locale(langProvider.appLang),
    );
  }
}