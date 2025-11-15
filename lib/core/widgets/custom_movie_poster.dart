import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
class CustomMoviePoster extends StatelessWidget {
  double imageWidth;
  double imageHeight;
  String image;
  double? rating;
   CustomMoviePoster({super.key, required this.imageWidth, required this.imageHeight,
    required this.image, required this.rating});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
            clipBehavior: Clip.antiAlias,
            width: imageWidth,
            height: imageHeight,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber
            ),
            child: Image.network(image, fit: BoxFit.fill,)
        ),
        Container(
          height: height*0.03,
          width: width*0.14,
          margin: EdgeInsets.symmetric(horizontal: width*0.02, vertical: height*0.01),
          decoration: BoxDecoration(
            color: AppColors.primaryColorWithObesity,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: width*0.02,
            children: [
          Text('$rating', style: AppStyles.reg16White),
          Image.asset(AppImages.starIcon, width: width*0.03, height: height*0.02,)
        ],),
        )
      ],
    );
  }
}
