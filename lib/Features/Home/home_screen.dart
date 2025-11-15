import 'package:flutter/material.dart';
import 'package:movie_project/Features/Home/tabs/browse_tap/browse_tab.dart';
import 'package:movie_project/Features/Home/tabs/home_tab/home_tab.dart';
import 'package:movie_project/Features/Home/tabs/profile_tap/profile_tab.dart';
import 'package:movie_project/Features/Home/tabs/search_tab/search_tab.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';


class HomeScreen extends StatefulWidget {
  final String? args; // nullable
  const HomeScreen({super.key, this.args});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as String;
    final token = widget.args;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<Widget> tabsList = [
      const HomeTabScreen(),
      const SearchTabScreen(),
      const BrowseTabScreen(),
      ProfileTabScreen(loginToken: token ?? '')
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: tabsList[selectedIndex],
          ),
          Positioned(
            left: width * 0.03,
            right: width * 0.03,
            bottom: height * 0.01,
            child: SafeArea(
              top: false,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: AppColors.transparentColor,
                    highlightColor: AppColors.transparentColor,
                    hoverColor: AppColors.transparentColor,
                  ),
                    child: BottomNavigationBar(
                      selectedItemColor: AppColors.secondColor,
                      unselectedItemColor: AppColors.whiteColor,
                      backgroundColor: AppColors.grayDarkColor,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      currentIndex: selectedIndex,
                      type: BottomNavigationBarType.fixed,
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      items: [
                        buildBottomNavBarItem(
                          index: 0,
                          selectedIconName: AppImages.homeIcon,
                          unSelectedIconName: AppImages.homeIcon,
                          label: 'Home',
                        ),
                        buildBottomNavBarItem(
                          index: 1,
                          selectedIconName: AppImages.searchIcon,
                          unSelectedIconName: AppImages.searchIcon,
                          label: 'Search',
                        ),
                        buildBottomNavBarItem(
                          index: 2,
                          selectedIconName: AppImages.browseIcon,
                          unSelectedIconName: AppImages.browseIcon,
                          label: 'Browse',
                        ),
                        buildBottomNavBarItem(
                          index: 3,
                          selectedIconName: AppImages.profileIcon,
                          unSelectedIconName: AppImages.profileIcon,
                          label: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ),
            ),
            ),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavBarItem({
    required String unSelectedIconName,
    required String selectedIconName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : unSelectedIconName,
        ),
      ),
      label:label,
    );
  }

}
