import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';

class BuiltAvatarRegister extends StatelessWidget {
  const BuiltAvatarRegister({super.key});
  final List avatarList =const [
    AppImages.avatar2,
    AppImages.avatar1,
    AppImages.avatar3,
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
         enlargeCenterPage: true,
         aspectRatio: 15/6,
         viewportFraction: 0.42,
         height: height * 0.20,
         enableInfiniteScroll: false,
         autoPlay: true,
      ),
      items: avatarList.map((e){
        return Image.asset(e,fit: BoxFit.cover,);
      },).toList()
    );
  }
}
