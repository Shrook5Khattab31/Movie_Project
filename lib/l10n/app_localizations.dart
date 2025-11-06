import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by AppLocalizations.of(context).
///
/// Applications need to include AppLocalizations.delegate() in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
  <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  String get email;
  String get password;
  String get forget_password;
  String get login;
  String get dont_have_acc;
  String get create_one;
  String get or;
  String get login_with_google;
  String get name;
  String get confirm_password;
  String get phone_number;
  String get create_acc;
  String get already_have_acc;
  String get verify_email;
  String get register;

  // Onboarding / app intro
  String get find_next_favorite_movie;
  String get access_huge_library;
  String get explore_now;
  String get discover_movies;
  String get explore_vast_collection;
  String get explore_all_genres;
  String get discover_movies_every_genre;
  String get create_watchlists;
  String get save_movies_watchlist;
  String get rate_review_learn;
  String get share_your_thoughts;
  String get start_watching_now;
  String get finish;
  String get next;
  String get back;

  // Password reset / account
  String get reset_password;
  String get old_password;
  String get new_password;
  String get rewrite_password;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
        'an issue with the localizations generation tool.',
  );
}