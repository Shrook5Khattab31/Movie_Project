import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/widgets/custom_language_switch_button.dart';
import 'package:movie_project/core/widgets/custom_text_button.dart';

import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_btn.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../l10n/app_localizations.dart';
import '../../core/constants/appAssets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
            Image.asset(
              fit: BoxFit.fill,
              "assets/images/app_logo.png",
              width: width * 0.3,
              height: height * 0.13,
            ),
            CustomTextFormField(
              controller: emailController,
              prefixIcon: const Icon(Icons.email_outlined),
              hintText: AppLocalizations.of(context)!.email,
              hintStyle: AppStyles.reg16White,
            ),
            CustomTextFormField(
              controller: passController,
              prefixIcon: const Icon(Icons.lock),
              hintText: AppLocalizations.of(context)!.password,
              suffixIcon: const Icon(Icons.visibility_off),
              hintStyle: AppStyles.reg16White,
            ),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: CustomTextButton(
                text: "${AppLocalizations.of(context)!.forget_password} ?",
                onPressed: (){
                  Navigator.pushNamed(context, AppRoutes.forgetPassScreen);
                },
                styleText: AppStyles.reg14Yellow
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (context)=>false);
                },
                text: AppLocalizations.of(context)!.login,
                backgroundColor: AppColors.secondColor,
                textStyle: AppStyles.reg20Black,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.dont_have_acc} ?",
                    style: AppStyles.reg14White,
                  ),
                  SizedBox(width: width * 0.02),
                  Text(
                    AppLocalizations.of(context)!.create_one,
                    style: AppStyles.bold14Yellow,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.secondColor,
                    indent: width * 0.15,
                    endIndent: width * 0.04,
                    thickness: 2,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.or,
                  style: AppStyles.reg15Yellow,
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.secondColor,
                    indent: width * 0.04,
                    endIndent: width * 0.15,
                    thickness: 2,
                  ),
                ),
              ],
            ),
            CustomElevatedButton(
              onPressed: () {},
              text: AppLocalizations.of(context)!.login_with_google,
              backgroundColor: AppColors.secondColor,
              textStyle: AppStyles.reg20Black,
            ),
            CustomToggleSwitch()
          ],
        ),
      ),
    );
  }
}