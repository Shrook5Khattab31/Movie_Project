import 'package:flutter/material.dart';
import 'package:movie_project/core/theme/appColors.dart';

import 'appStyles.dart';

class DarkAppTheme {
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryColor,
    iconTheme: IconThemeData(
      color: AppColors.whiteColor,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColors.secondColor,
      unselectedLabelStyle: AppStyles.bold20White,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.whiteColor,
      unselectedLabelColor: AppColors.whiteColor,
      labelStyle: AppStyles.bold20White,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.secondColor,
      circularTrackColor: AppColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      elevation: 0,
    ),
  );
}