import 'package:flutter/material.dart';
import 'package:movie_project/Model/favorites/favorite.dart';

import '../../Model/MoviesModel/Movies.dart';
import '../../l10n/app_localizations.dart';
import '../constants/appAssets.dart';
import '../routing/routeNames.dart';
import '../theme/appColors.dart';
import '../theme/appStyles.dart';
import '../widgets/custom_elevated_btn.dart';

class CustomProfileBuilder {
  static Padding buildProfileHeader({
    required BuildContext context,
    required String avatarPath,
    required String userName,
    required double width,
    required List<Favorite> favoriteMovies,
    required List<Movies> history,
    required double height,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Image.asset(avatarPath),
                SizedBox(height: height * 0.01),
                Text(userName, style: AppStyles.bold20White),
              ],
            ),
          ),
          SizedBox(width: width * 0.03),
          Column(
            children: [
              Text('${favoriteMovies.length}', style: AppStyles.bold36White),
              SizedBox(height: height * 0.02),
              Text(
                AppLocalizations.of(context)!.watch_list,
                style: AppStyles.bold24White,
              ),
            ],
          ),
          SizedBox(width: width * 0.08),
          Column(
            children: [
              Text('${history.length}', style: AppStyles.bold36White),
              SizedBox(height: height * 0.02),
              Text(
                AppLocalizations.of(context)!.history,
                style: AppStyles.bold24White,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildActionButtons({
    required BuildContext context,
    required double width,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomElevatedButton(
              text: AppLocalizations.of(context)!.edit_profile,
              textStyle: AppStyles.reg20Black,
              onPressed: onPressed,
            ),
          ),
          SizedBox(width: width * 0.02),
          Expanded(
            child: CustomElevatedButton(
              haveIcon: true,
              iconWidget: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.exit,
                      style: AppStyles.reg20White,
                    ),
                    SizedBox(width: width * 0.01),
                    Image.asset(AppImages.exitIcon),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              },
              backgroundColor: AppColors.redColor,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildProfileTabs({required BuildContext context}) {
    return TabBar(
      indicatorWeight: 3,
      tabs: [
        Tab(
          icon: Image.asset(AppImages.watchIcon),
          text: AppLocalizations.of(context)!.watch_list,
        ),
        Tab(
          icon: Image.asset(AppImages.historyIcon),
          text: AppLocalizations.of(context)!.history,
        ),
      ],
    );
  }
}
