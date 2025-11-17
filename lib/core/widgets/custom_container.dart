import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
class CustomContainer extends StatelessWidget {
  String icon;
  String text;
  CustomContainer({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    return Container(
      width: width*0.3,
      padding: EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.01),
      decoration: BoxDecoration(
        color: AppColors.grayDarkColor,
        borderRadius: BorderRadius.circular(16)
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: width*0.03,
        children: [
        Image.asset(icon),
        Text(text, style: AppStyles.bold24White,)
      ],),
    );
  }
}
