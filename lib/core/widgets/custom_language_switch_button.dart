import 'package:flutter/material.dart';
import 'package:movie_project/provider/langProvider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../constants/appAssets.dart';
import '../theme/appColors.dart';

class CustomToggleSwitch extends StatelessWidget {
  const CustomToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LangProvider>(context);
    int currentIndex = langProvider.appLang == "en"? 0:1;
    return ToggleSwitch(
      borderWidth: 3,
      minWidth: 50.0,
      radiusStyle: true,
      inactiveBgColor: AppColors.transparentColor,
      cornerRadius: 30.0,
      borderColor: [AppColors.secondColor],
      activeBgColor: [AppColors.secondColor],
      totalSwitches: 2,
      customWidgets: [
        Image.asset(AppImages.usa),
        Image.asset(AppImages.egypt),
      ],
      onToggle: (index) {
        if(index == 0){
          langProvider.changeLang("en");
        } else {
          langProvider.changeLang("ar");
        }
      },
      initialLabelIndex: currentIndex,
    );
  }
}