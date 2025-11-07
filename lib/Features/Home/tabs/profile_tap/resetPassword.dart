import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/core/widgets/custom_text_form_field.dart';
import 'package:movie_project/l10n/app_localizations.dart';

class ResetPassword extends StatelessWidget{
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    // TODO: implement build
    TextEditingController passController = TextEditingController();
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title:Text(AppLocalizations.of(context)!.reset_password
          ,style: AppStyles.reg16Yellow,),
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back_sharp,
            color: AppColors.secondColor,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: width*0.04),
          child: Column(
        
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AppImages.forgotPasswordImage),
              CustomTextFormField(
                  controller: passController,
                  prefixIcon:Image.asset( AppImages.passwordIcon),
                  suffixIcon: Icon(Icons.visibility_off),
                  hintText: AppLocalizations.of(context)!.old_password,
                  hintStyle: AppStyles.reg16White),
              SizedBox(height: height*0.02,),
              CustomTextFormField(
                  controller: passController,
                  prefixIcon:Image.asset( AppImages.passwordIcon),
                  suffixIcon: Icon(Icons.visibility_off),
                  hintText: AppLocalizations.of(context)!.new_password,
                  hintStyle: AppStyles.reg16White),
              SizedBox(height: height*0.02,),
              CustomTextFormField(
                  controller: passController,
                  prefixIcon:Image.asset( AppImages.passwordIcon),
                  suffixIcon: Icon(Icons.visibility_off),
                  hintText: AppLocalizations.of(context)!.rewrite_password,
                  hintStyle: AppStyles.reg16White),
              SizedBox(height: height*0.05,),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                    onPressed: () {},
                    backgroundColor: AppColors.secondColor,
                    text: AppLocalizations.of(context)!.reset_password,
                    textStyle: AppStyles.reg20Black,)
              ),
              SizedBox(height: height*0.05,)
            ],
          ),
        ),
      ),
    );
  }

}