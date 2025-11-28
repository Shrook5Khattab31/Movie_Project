import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dont_have_acc.
  ///
  /// In en, this message translates to:
  /// **'Don’t Have Account'**
  String get dont_have_acc;

  /// No description provided for @create_one.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get create_one;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone_number;

  /// No description provided for @create_acc.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_acc;

  /// No description provided for @already_have_acc.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account'**
  String get already_have_acc;

  /// No description provided for @verify_email.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verify_email;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @old_password.
  ///
  /// In en, this message translates to:
  /// **'Old password'**
  String get old_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get new_password;

  /// No description provided for @rewrite_password.
  ///
  /// In en, this message translates to:
  /// **'Rewrite password'**
  String get rewrite_password;

  /// No description provided for @pick_avatar.
  ///
  /// In en, this message translates to:
  /// **'Pick Avatar'**
  String get pick_avatar;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @update_data.
  ///
  /// In en, this message translates to:
  /// **'Update Data'**
  String get update_data;

  /// No description provided for @find_next_favorite_movie.
  ///
  /// In en, this message translates to:
  /// **'Find Your Next\nFavorite Movie Here'**
  String get find_next_favorite_movie;

  /// No description provided for @access_huge_library.
  ///
  /// In en, this message translates to:
  /// **'Get access to a huge library of movies\nto suit all tastes. You will surely like it.'**
  String get access_huge_library;

  /// No description provided for @explore_now.
  ///
  /// In en, this message translates to:
  /// **'Explore Now'**
  String get explore_now;

  /// No description provided for @discover_movies.
  ///
  /// In en, this message translates to:
  /// **'Discover Movies'**
  String get discover_movies;

  /// No description provided for @explore_vast_collection.
  ///
  /// In en, this message translates to:
  /// **'Explore a vast collection of movies in all\nqualities and genres. Find your next\nfavorite film with ease.'**
  String get explore_vast_collection;

  /// No description provided for @explore_all_genres.
  ///
  /// In en, this message translates to:
  /// **'Explore All Genres'**
  String get explore_all_genres;

  /// No description provided for @discover_movies_every_genre.
  ///
  /// In en, this message translates to:
  /// **'Discover movies from every genre,\nin all available qualities. Find something new\nand exciting to watch every day.'**
  String get discover_movies_every_genre;

  /// No description provided for @create_watchlists.
  ///
  /// In en, this message translates to:
  /// **'Create Watchlists'**
  String get create_watchlists;

  /// No description provided for @save_movies_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Save movies to your watchlist to keep\ntrack of what you want to watch next.\nEnjoy films in various qualities and genres.'**
  String get save_movies_watchlist;

  /// No description provided for @rate_review_learn.
  ///
  /// In en, this message translates to:
  /// **'Rate, Review, and Learn'**
  String get rate_review_learn;

  /// No description provided for @share_your_thoughts.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts on the movies\nyou\'ve watched. Dive deep into\nfilm details and help others discover\ngreat movies with your reviews.'**
  String get share_your_thoughts;

  /// No description provided for @start_watching_now.
  ///
  /// In en, this message translates to:
  /// **'Start Watching Now'**
  String get start_watching_now;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @watch_list.
  ///
  /// In en, this message translates to:
  /// **'Watch List'**
  String get watch_list;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get edit_profile;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @login_successfully.
  ///
  /// In en, this message translates to:
  /// **'Login successfully'**
  String get login_successfully;

  /// No description provided for @successfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully'**
  String get successfully;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @watch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get watch;

  /// No description provided for @genres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get genres;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @see_more.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get see_more;

  /// No description provided for @screen_shots.
  ///
  /// In en, this message translates to:
  /// **'Screen Shots'**
  String get screen_shots;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @similar.
  ///
  /// In en, this message translates to:
  /// **'Similar'**
  String get similar;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @cast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get cast;

  /// No description provided for @adventure.
  ///
  /// In en, this message translates to:
  /// **'Adventure'**
  String get adventure;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get animation;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;

  /// No description provided for @wish_list.
  ///
  /// In en, this message translates to:
  /// **'Wish List'**
  String get wish_list;

  /// No description provided for @errorLoadingMovie.
  ///
  /// In en, this message translates to:
  /// **'Error loading movie'**
  String get errorLoadingMovie;

  /// No description provided for @noMovieData.
  ///
  /// In en, this message translates to:
  /// **'No movie data available'**
  String get noMovieData;

  /// No description provided for @noSummary.
  ///
  /// In en, this message translates to:
  /// **'No Summary Available'**
  String get noSummary;

  /// No description provided for @character.
  ///
  /// In en, this message translates to:
  /// **'Character :'**
  String get character;

  /// No description provided for @noCast.
  ///
  /// In en, this message translates to:
  /// **'No cast available'**
  String get noCast;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile'**
  String get errorLoadingProfile;

  /// No description provided for @googleUser.
  ///
  /// In en, this message translates to:
  /// **'Google User'**
  String get googleUser;

  /// No description provided for @oldPasswordNull.
  ///
  /// In en, this message translates to:
  /// **'Old password shouldn\'t be null'**
  String get oldPasswordNull;

  /// No description provided for @newPasswordNull.
  ///
  /// In en, this message translates to:
  /// **'New password shouldn\'t be null'**
  String get newPasswordNull;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password should at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Password should contains at least one upper letter,\n one lower letter, \n one digit and \none special character'**
  String get passwordRequirements;

  /// No description provided for @passwordNull.
  ///
  /// In en, this message translates to:
  /// **'Password shouldn\'t be null'**
  String get passwordNull;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Password doesn\'t match'**
  String get passwordMismatch;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get passwordUpdated;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error, please try again!'**
  String get networkError;

  /// No description provided for @oldPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Old password doesn\'t match!'**
  String get oldPasswordMismatch;

  /// No description provided for @somethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went Wrong!'**
  String get somethingWrong;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error!'**
  String get unexpectedError;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessfully;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User is not found!, please try again'**
  String get userNotFound;

  /// No description provided for @registerSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Register successfully'**
  String get registerSuccessfully;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Please make sure the phone number starts with +20 and contains 11 number'**
  String get invalidPhone;
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
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
