import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/core/widgets/custom_text_button.dart';
import '../../../../core/theme/appColors.dart';
import '../../../../core/theme/appStyles.dart';
import '../../../../l10n/app_localizations.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  final List<String> avatars = [
    AppImages.avatar1,AppImages.avatar2,AppImages.avatar3,
    AppImages.avatar4,AppImages.avatar5,AppImages.avatar6,
    AppImages.avatar7,AppImages.avatar8,AppImages.avatar9
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title:Text(AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.reg16Yellow,),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_sharp,
            color: AppColors.secondColor,),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.04),
        child: Column(
          spacing: height*0.02,
          children: [
            GestureDetector(
              onTap: ()=> showAvatars(context),
              child: Padding(
                padding: EdgeInsetsGeometry.directional(top: height*0.03,bottom: height*0.01),
                child: Image.asset(AppImages.avatar1),
              ),
            ),
            personInfoBox(text: 'Route Academy', icon: Icons.person_2,
                height: height*0.06,iconPadding: width*0.04),
            personInfoBox(text: '01200000000', icon: Icons.phone_rounded,
                height: height*0.06,iconPadding: width*0.04),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: CustomTextButton(
                text: AppLocalizations.of(context)!.reset_password,
                onPressed: ()=> Navigator.pushNamed(context, AppRoutes.resetPassScreen),
                styleText: AppStyles.reg20White
              ),
            ),
            Expanded(child: SizedBox()),
            CustomElevatedButton(
              text: AppLocalizations.of(context)!.delete_account,
              textStyle: AppStyles.reg20White,
              onPressed: (){},
              backgroundColor: AppColors.redColor
            ),
            CustomElevatedButton(
                text: AppLocalizations.of(context)!.update_data,
                textStyle: AppStyles.reg20Black,
                onPressed: (){},
                backgroundColor: AppColors.secondColor
            ),
            SizedBox(height: height*0.03,)
          ],
        ),
      ),
    );
  }
  Container personInfoBox({required String text, required IconData icon, double height=0,double iconPadding = 16}){
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.grayDarkColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:iconPadding),
            child: Icon(icon),
          ),
          Text(text, style: AppStyles.reg20White,),
        ],
      ),
    );
  }

  Future showAvatars(BuildContext context) async {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.03),
      child: await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.transparentColor,
        builder: (context) {
          return Container(
            height: height*0.46,
            padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.04),
            decoration: BoxDecoration(
              color: AppColors.grayDarkColor,
              borderRadius: BorderRadius.circular(24),
            ),
            margin: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.04),
            child: GridView.builder(
              itemCount: avatars.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: width*0.02,
                mainAxisSpacing: height*0.02,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondColor,),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(avatars[index], fit: BoxFit.cover),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
