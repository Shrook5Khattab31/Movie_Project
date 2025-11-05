import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../constants/appAssets.dart';
import '../theme/appColors.dart';

class CustomToggleSwitch extends StatelessWidget {
  const CustomToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
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
      onToggle: (index) {},
    );
  }
}
