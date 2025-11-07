import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';

class ProfileTabScreen extends StatelessWidget{
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final double width= MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.grayDarkColor,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.05),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(AppImages.avatar1,width: width*0.27, height: height*0.12,),
                          Column(
                            children: [
                              Text(' 12 \n', textAlign: TextAlign.center,),
                              Text('Wish List', textAlign: TextAlign.center,),
                            ],
                          ),
                          Column(
                            children: [
                              Text('10 \n', textAlign: TextAlign.center,),
                              Text('History', textAlign: TextAlign.center,),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        spacing: width*0.02,
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomElevatedButton(
                              text: 'Edit Profile',
                              onPressed: (){},
                              backgroundColor: AppColors.secondColor
                            ),
                          ),
                          Expanded(
                            child: CustomElevatedButton(
                                text: 'Exit',
                                onPressed: (){},
                                backgroundColor: AppColors.redColor
                            ),
                          ),
                        ],
                      ),
                      DefaultTabController(
                        length: 2,
                        child: TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(Icons.format_list_bulleted_rounded),
                            ),
                            Tab(
                              icon: Icon(Icons.folder),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column()
          ),
        ],
      ),
    );
  }
}