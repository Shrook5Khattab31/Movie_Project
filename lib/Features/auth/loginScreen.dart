import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/widgets/custom_language_switch_button.dart';
import 'package:movie_project/core/widgets/custom_text_button.dart';
import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/utils/custom_dialog.dart';
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
              onTap: () => Navigator.pushNamed(context, AppRoutes.register),
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
              haveIcon: true,
              onPressed: () {
                //todo login with google
                loginGoogle();
              },
              text: AppLocalizations.of(context)!.login_with_google,
              backgroundColor: AppColors.secondColor,
              textStyle: AppStyles.reg16Black,
              iconWidget:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: width*0.02,
                children: [
                  Image.asset(AppImages.googleIcon, width: width*0.06, height: height*0.03,),
                  Text(AppLocalizations.of(context)!.login_with_google, style: AppStyles.reg16Black)
                ],)

            ),
            CustomToggleSwitch()
          ],
        ),
      ),
    );
  }
  void loginGoogle()async{
    //todo show loading
    CustomDialog.showLoading(
      context: context,
      background: AppColors.primaryColor,
      text: AppLocalizations.of(context)!.loading,
      style: AppStyles.bold20Yellow,
    );
    try {
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();
      if (googleUser == null) {
        //todo hide loading
        CustomDialog.hideLoading(context: context);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint('---------------------------------------');
      debugPrint('UID: ${googleUser.id}');
      debugPrint('Name: ${googleUser.displayName ?? ""}');
      debugPrint('Email: ${googleUser.email}');
      debugPrint('---------------------------------------');
      //todo hide loading
      CustomDialog.hideLoading(context: context);
      //todo show message successfully
      CustomDialog.showMessage(
        context: context,
        background: AppColors.primaryColor,
        title: AppLocalizations.of(context)!.successfully,
        styleTitle: AppStyles.bold20Yellow,
        message: AppLocalizations.of(context)!.login_successfully,
        styleMessage: AppStyles.reg16White,
        posActionName: AppLocalizations.of(context)!.ok,
        stylePosActionName:AppStyles.bold20Yellow,
        posActionClick: () {
         //todo nav into home
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen,(route) => false,);
        },
      );
    } on Exception catch (e) {
      //todo hide loading
      CustomDialog.hideLoading(context: context);
      //todo show message error
      CustomDialog.showMessage(
        context: context,
        background: AppColors.primaryColor,
        title: AppLocalizations.of(context)!.error,
        styleTitle: AppStyles.bold20Yellow,
        message: e.toString(),
        styleMessage: AppStyles.reg16White,
        posActionName: AppLocalizations.of(context)!.ok,
        stylePosActionName:AppStyles.bold20Yellow,
      );
    }
  }
}