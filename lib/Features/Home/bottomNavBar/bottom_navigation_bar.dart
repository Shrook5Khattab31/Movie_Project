import 'package:flutter/material.dart';
import 'package:movie_project/Features/Home/Taps/browseTap/browse_tab_screen.dart';
import 'package:movie_project/Features/Home/Taps/homeTap/home_tab_screen.dart';
import 'package:movie_project/Features/Home/Taps/profileTap/profile_tab_screen.dart';
import 'package:movie_project/Features/Home/Taps/searchTap/search_tab_screen.dart';
import 'package:movie_project/core/constants/appAssets.dart';

import 'package:movie_project/core/theme/appColors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  List<Widget> TabsList = [
    HomeTabScreen(),
    SearchTabScreen(),
    BrowseTabScreen(),
    ProfileTabScreen(),
  ];
late double height;
late double width;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: TabsList[selectedIndex],
          ),
          Positioned(
            left: width * 0.02,
            right: width * 0.02,
            bottom: height * 0.03,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
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
                      ubSelectedIconName: AppImages.homeIcon,
                      label: 'Home',
                    ),
                    buildBottomNavBarItem(
                      index: 1,
                      selectedIconName: AppImages.searchIcon,
                      ubSelectedIconName: AppImages.searchIcon,
                      label: 'Search',
                    ),
                    buildBottomNavBarItem(
                      index: 2,
                      selectedIconName: AppImages.browseIcon,
                      ubSelectedIconName: AppImages.browseIcon,
                      label: 'Browse',
                    ),
                    buildBottomNavBarItem(
                      index: 3,
                      selectedIconName: AppImages.profileIcon,
                      ubSelectedIconName: AppImages.profileIcon,
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavBarItem({
    required String ubSelectedIconName,
    required String selectedIconName,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon:  ImageIcon(
            AssetImage(
              selectedIndex == index ? selectedIconName : ubSelectedIconName,
            ),
          ),
      label: label,
    );
  }
}