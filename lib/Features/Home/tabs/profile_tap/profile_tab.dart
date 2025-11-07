import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/l10n/app_localizations.dart';

import '../../../../core/widgets/custom_elevated_btn.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                color: AppColors.lightBlackColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset(AppImages.avatar1),
                                SizedBox(height: height * 0.01),
                                Text(
                                  "John Safwat",
                                  style: AppStyles.bold20White,
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Column(
                            children: [
                              Text("12", style: AppStyles.bold36White),
                              SizedBox(height: height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.watch_list,
                                style: AppStyles.bold24White,
                              )
                            ],
                          ),
                          SizedBox(width: width * 0.08),
                          Column(
                            children: [
                              Text("10", style: AppStyles.bold36White),
                              SizedBox(height: height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.history,
                                style: AppStyles.bold24White,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              text: AppLocalizations.of(context)!.edit_profile,
                              textStyle: AppStyles.reg20Black,
                              onPressed: () {
                                Navigator.of(context).pushNamed(AppRoutes.updateProfileScreen);
                              },
                              backgroundColor: AppColors.secondColor,
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          Expanded(
                            child: CustomElevatedButton(
                              haveIcon: true,
                              icon: Image.asset(AppImages.exitIcon),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutes.login,
                                        (route) => false,);
                              },
                              backgroundColor: AppColors.redColor,
                              text: AppLocalizations.of(context)!.exit,
                              textStyle: AppStyles.reg20White,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    TabBar(
                      indicatorColor: AppColors.secondColor,
                      indicatorWeight:3,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColors.whiteColor,
                      labelStyle: AppStyles.bold20White,
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
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.primaryColor,
                  child: TabBarView(
                    children: [
                      Center(child: Image.asset(AppImages.emptyList)),
                      Center(child: Image.asset(AppImages.emptyList)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
