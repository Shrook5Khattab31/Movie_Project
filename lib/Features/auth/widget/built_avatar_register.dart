import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';

class BuiltAvatarRegister extends StatefulWidget {
  final Function(int)? onAvatarChanged;
  const BuiltAvatarRegister({super.key, this.onAvatarChanged});

  @override
  State<BuiltAvatarRegister> createState() => _BuiltAvatarRegisterState();
}

class _BuiltAvatarRegisterState extends State<BuiltAvatarRegister> {
  final List avatarList = const [
    AppImages.avatar2,
    AppImages.avatar1,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9
  ];
  int currentIndex = 0;
  bool isAutoPlay = true;
  CarouselSliderController? carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        enlargeCenterPage: true,
        aspectRatio: 15 / 6,
        viewportFraction: height * 0.00054,
        height: height * 0.18,
        enableInfiniteScroll: false,
        autoPlay: isAutoPlay,
        initialPage: currentIndex,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
          if (widget.onAvatarChanged != null) {
            widget.onAvatarChanged!(index);
          }
        },
      ),
      items: avatarList.map((e) {
        return InkWell(
            onTap: (){
              setState(() {
                isAutoPlay = false;
                currentIndex = avatarList.indexOf(e);
              });
              carouselController!.animateToPage(currentIndex);
              if (widget.onAvatarChanged != null) {
                widget.onAvatarChanged!(currentIndex+1);
              }
            },
            child: Image.asset(e,fit: BoxFit.cover,));
      },).toList()
    );
  }
}
