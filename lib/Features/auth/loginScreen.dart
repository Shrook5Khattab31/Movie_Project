import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_project/core/widgets/custom_language_switch_button.dart';

import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_btn.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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

    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //todo add logo photo
            Image.asset("assets/images/app_logo.png",
              width: width * 0.3, height: height * 0.13, fit: BoxFit.fill,),
            CustomTextFormField(
                controller: emailController,
                prefixIcon: Icon(Icons.email_outlined),
                hintText: AppLocalizations.of(context)!.email,
                hintStyle: AppStyles.reg16White),
            CustomTextFormField(controller: passController,
              prefixIcon: Icon(Icons.lock),
              hintText: AppLocalizations.of(context)!.password,
              suffixIcon: Icon(Icons.visibility_off),
              hintStyle: AppStyles.reg16White,),
            InkWell(
              onTap: () {
                //todo go to forget pass screen
              },
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "${AppLocalizations.of(context)!.forget_password} ?",
                  style: AppStyles.reg14Yellow, textAlign: TextAlign.end,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                  onPressed: () {}, color: AppColors.secondColor,
                  child: Text(AppLocalizations.of(context)!.login
                    , style: AppStyles.reg20Black,
                  )),
            ),
            InkWell(
              onTap: () {
                //todo go to register screen
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: width * 0.02,
                children: [
                  Text("${AppLocalizations.of(context)!.dont_have_acc} ?",
                      style: AppStyles.reg14White),
                  Text(AppLocalizations.of(context)!.create_one,
                      style: AppStyles.bold14Yellow),
                ],),
            ),
            Row(children: [
              Expanded(child:
              Divider(color: AppColors.secondColor,
                indent: width * 0.15, endIndent: width * 0.04, thickness: 2,)),
              Text(AppLocalizations.of(context)!.or,
                style: AppStyles.reg15Yellow,),
              Expanded(child:
              Divider(color: AppColors.secondColor, indent: width * 0.04,
                endIndent: width * 0.15, thickness: 2,)),

            ],),
            CustomElevatedButton(onPressed: () {},
                color: AppColors.secondColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: width * 0.02,
                  children: [
                    //todo add google logo
                    Image.asset("assets/images/google_icon.png", width: width*0.06, height: height*0.03,),
                    //Image.asset(AppAssets.google_icon, width: width*0.06, height: height*0.03,),
                    Text(AppLocalizations.of(context)!.login_with_google,
                      style: AppStyles.reg16Black,)
                  ],)
            ),
            CustomToggleSwitch()
          ],),
      ),
    );
  }
}