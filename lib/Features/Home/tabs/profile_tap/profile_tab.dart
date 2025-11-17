import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/l10n/app_localizations.dart';
import '../../../../api/api_service.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';

class ProfileTabScreen extends StatefulWidget {
  String loginToken;
  bool isGoogleLogin =false;
  ProfileTabScreen({super.key, required this.loginToken,});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late Future<Map<String, dynamic>> profileFuture;
  int currentAvatarId = 1;
  final List<String> avatars = [
    AppImages.avatar1, AppImages.avatar2, AppImages.avatar3,
    AppImages.avatar4, AppImages.avatar5, AppImages.avatar6,
    AppImages.avatar7, AppImages.avatar8, AppImages.avatar9
  ];

  @override
  void initState() {
    super.initState();
    if(widget.loginToken==''){
      widget.isGoogleLogin=!widget.isGoogleLogin;
    }
    profileFuture = ApiService().getProfile(widget.loginToken);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: FutureBuilder<Map<String, dynamic>>(
          future: profileFuture,
          builder: (context,snapshot) {
            if(widget.isGoogleLogin==false){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading profile"));
              }
              final data = snapshot.data!;
              final userName = data['name'] ?? 'User';
              currentAvatarId = snapshot.data!['avaterId'] ?? currentAvatarId;
              int index = (currentAvatarId >= 1 && currentAvatarId <= avatars.length)
                  ? currentAvatarId - 1 : 0;
              var avatarPath = avatars[index];
              return SafeArea(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.lightBlackColor,
                      child: Column(
                        children: [
                          buildProfileHeader(
                              avatarPath: avatarPath, userName: userName,
                              width: width, height: height),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CustomElevatedButton(
                                    text: AppLocalizations.of(context)!.edit_profile,
                                    textStyle: AppStyles.reg20Black,
                                    onPressed: () async {
                                      final result = await Navigator.of(context).pushNamed(
                                        AppRoutes.updateProfileScreen,
                                        arguments: widget.loginToken,
                                      );
                                      if (result != null && result is int) {
                                        setState(() {
                                          avatarPath = avatars[result - 1];
                                          profileFuture = ApiService().getProfile(widget.loginToken);
                                        });
                                      }
                                    },
                                    backgroundColor: AppColors.secondColor,
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
                                          Text(AppLocalizations.of(context)!.exit,style: AppStyles.reg20White,),
                                          SizedBox(width: width*0.01,),
                                          Image.asset(AppImages.exitIcon)
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                        AppRoutes.login,
                                            (route) => false,);
                                    },
                                    backgroundColor: AppColors.redColor,
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
                      child: TabBarView(
                        children: [
                          Center(child: Image.asset(AppImages.emptyList)),
                          Center(child: Image.asset(AppImages.emptyList)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }else{
              return Column(
                children: [
                  Container(
                  color: AppColors.lightBlackColor,
                  child: Column(
                    children: [
                      buildProfileHeader(avatarPath: avatars[0],
                          userName: FirebaseAuth.instance.currentUser?.displayName ?? "Google User",
                          width: width, height: height),
                      Container(
                        width: double.infinity,
                        height: height*0.06,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: CustomElevatedButton(
                          haveIcon: true,
                          iconWidget: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!.exit,style: AppStyles.reg20White,),
                                SizedBox(width: width*0.01,),
                                Image.asset(AppImages.exitIcon)
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.login,
                              (route) => false,);
                          },
                          backgroundColor: AppColors.redColor,
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
                  )
                ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Image.asset(AppImages.emptyList)),
                        Center(child: Image.asset(AppImages.emptyList)),
                      ],
                    ),
                  ),
                ]
              );
            }
          }
        ),
      ),
    );
  }
  Padding buildProfileHeader({required String avatarPath,
    required String userName, required double width,
    required double height,}){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.04),
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
              Text("12", style: AppStyles.bold36White),
              SizedBox(height: height * 0.02),
              Text(AppLocalizations.of(context)!.watch_list, style: AppStyles.bold24White),
            ],
          ),
          SizedBox(width: width * 0.08),
          Column(
            children: [
              Text("10", style: AppStyles.bold36White),
              SizedBox(height: height * 0.02),
              Text(AppLocalizations.of(context)!.history, style: AppStyles.bold24White),
            ],
          ),
        ],
      ),
    );
  }
}
