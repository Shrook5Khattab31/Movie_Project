import 'package:flutter/material.dart';
import 'package:movie_project/Features/Home/Taps/browseTap/browse_screen.dart';
import 'package:movie_project/Features/Home/Taps/homeTap/homeTap_screen.dart';
import 'package:movie_project/Features/Home/Taps/profileTap/profile_screen.dart';
import 'package:movie_project/Features/Home/Taps/searchTap/search_screen.dart';
import 'package:movie_project/core/theme/appColors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  List<Widget> TapsList = [
    HomeTapScreen(),
    SearchScreen(),
    BrowseScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: TapsList[selectedIndex],
          ),

          Positioned(
            left: width * 0.02,
            right: width * 0.02,
            bottom: height * 0.03,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: BottomNavigationBar(
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
                    selectedIconName: 'assets/icons/home_selected.png',
                    ubSelectedIconName: 'assets/icons/home.png',
                    label: 'Home',
                  ),
                  buildBottomNavBarItem(
                    index: 1,
                    selectedIconName: 'assets/icons/search_selected.png',
                    ubSelectedIconName: 'assets/icons/search.png',
                    label: 'Search',
                  ),
                  buildBottomNavBarItem(
                    index: 2,
                    selectedIconName: 'assets/icons/browse_selected.png',
                    ubSelectedIconName: 'assets/icons/browse.png',
                    label: 'Browse',
                  ),
                  buildBottomNavBarItem(
                    index: 3,
                    selectedIconName: 'assets/icons/profile_selected.png',
                    ubSelectedIconName: 'assets/icons/profile.png',
                    label: 'Profile',
                  ),
                ],
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
      icon: ImageIcon(
        AssetImage(
          selectedIndex == index ? selectedIconName : ubSelectedIconName,
        ),
      ),
      label: label,
    );
  }
}