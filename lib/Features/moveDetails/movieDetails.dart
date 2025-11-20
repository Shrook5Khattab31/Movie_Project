import 'package:flutter/material.dart';
import 'package:movie_project/Model/Movies.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_container.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/l10n/app_localizations.dart';

class MovieDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)!.settings.arguments as Movies;
    return Scaffold(
      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height*0.7,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(args.mediumCoverImage??""
                        ),fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: height*0.7,
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [
                      AppColors.primaryColorWithObesity80,
                      AppColors.primaryColorWithObesity60,
                      AppColors.primaryColor,
                    ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      stops: [
                        0.0,
                       0.47,
                       1.0,
                      ],
                    )),
                  ),
                 Container(
                   height: height * 0.7,
                   padding: EdgeInsets.symmetric(horizontal: width*0.03, vertical: height*0.02),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           InkWell(
                               onTap: (){
                                 Navigator.of(context).pop();
                               },
                               child: Icon(Icons.arrow_back_ios_outlined, color: AppColors.whiteColor)),
                           Icon(Icons.bookmark)
                         ],),
                       Expanded(child: Image.asset(AppImages.play)),
                       Text(args.title??"", style: AppStyles.bold24White,
                         textAlign: TextAlign.center,),
                       Text("${args.year}", style: AppStyles.bold20Gray, textAlign: TextAlign.center,)],),
                 ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width*0.03, vertical: height*0.01),
                  decoration: BoxDecoration(color: Colors.black),
                  child: Column(
                    spacing: height*0.02,
                    children: [
                    CustomElevatedButton(
                      onPressed: () {}, backgroundColor: AppColors.redColor,
                      text: AppLocalizations.of(context)!.watch, textStyle: AppStyles.bold20White,
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomContainer(icon: AppImages.likeIcon, text: "15"),
                        CustomContainer(icon: AppImages.timeIcon, text: "${args.runtime}"),
                        CustomContainer(icon: AppImages.starIcon, text: "${args.rating}")

                      ],),
                     ],
                  )
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.005),
                child: Text(AppLocalizations.of(context)!.cast,style: AppStyles.bold24White,),
              ),
              ///cast widget hna
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.005),
                child: Text(AppLocalizations.of(context)!.genres,style: AppStyles.bold24White,),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.037,vertical: height*0.005),
                child: Wrap(
                  spacing: width * 0.04,
                  runSpacing: height * 0.015,
                  children: (args.genres)!.map((genre) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.04, vertical: width * 0.02),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlackColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        genre.toString(),
                        style: AppStyles.reg16White,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],),
        )
      ),
    );
  }

}