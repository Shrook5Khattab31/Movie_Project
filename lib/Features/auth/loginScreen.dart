import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_project/Features/auth/widget/already_and_donot_have_account.dart';
import 'package:movie_project/api/api_service.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/utils/validator_helper.dart';
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
  String? loginToken;
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AppImages.appLogoAuth,
                fit: BoxFit.fill,
                width: width * 0.3,
                height: height * 0.13,
              ),

              CustomTextFormField(
                validatorFunc: (text) =>ValidatorHelper.validateEmail(text),
                controller: emailController,
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: AppLocalizations.of(context)!.email,
                hintStyle: AppStyles.reg16White,
              ),
              CustomTextFormField(
                validatorFunc: (text) =>ValidatorHelper.validatePassword(text),
                isPassword: isVisible ? false : true,
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                hintText: AppLocalizations.of(context)!.password,
                suffixIcon: IconButton(
                  onPressed: () {
                    //todo show pass
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: isVisible
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
                hintStyle: AppStyles.reg16White,
              ),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: CustomTextButton(
                  text: "${AppLocalizations.of(context)!.forget_password} ?",
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgetPassScreen);
                  },
                  styleText: AppStyles.reg14Yellow,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () {
                    login();
                  },
                  text: AppLocalizations.of(context)!.login,
                  backgroundColor: AppColors.secondColor,
                  textStyle: AppStyles.reg20Black,
                ),
              ),
              AlreadyAndDonotHaveAccount(
                text: "${AppLocalizations.of(context)!.dont_have_acc} ?",
                textButton: AppLocalizations.of(context)!.create_one,
                onPressedButton: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
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
                onPressed: () => loginGoogle(),
                text: AppLocalizations.of(context)!.login_with_google,
                backgroundColor: AppColors.secondColor,
                textStyle: AppStyles.reg16Black,
                iconWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: width * 0.02,
                  children: [
                    Image.asset(
                      AppImages.googleIcon,
                      width: width * 0.06,
                      height: height * 0.03,
                    ),
                    Text(
                      AppLocalizations.of(context)!.login_with_google,
                      style: AppStyles.reg16Black,
                    ),
                  ],
                ),
              ),
              CustomToggleSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      CustomDialog.showLoading(context: context,text: AppLocalizations.of(context)!.loading,);
      try {
        var response = await ApiService().signIn(
          email: emailController.text,
          password: passController.text,
        );
        if (response.data['message'] == 'Success Login') {
          widget.loginToken = response.data["data"];
          print("token ${widget.loginToken}");
          CustomDialog.hideLoading(context: context);
          CustomDialog.showMessage(
            context: context,
            title: "Success",
            message: "Login Successfully",
            posActionName: "Go to home",
            posActionClick: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeScreen,
                (route) => false,
                arguments: widget.loginToken,
              );
            },
          );
        }
      } on DioException catch (e) {
        CustomDialog.hideLoading(context: context);
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          CustomDialog.showMessage(
            context: context,
            title: "Error",
            message: "Network error, please try again!",
            posActionName: "Ok",
          );
        } else if (e.response!.statusCode == 400) {
          CustomDialog.showMessage(
            context: context,
            title: "Error",
            message: "User is not found!, please try again",
            posActionName: "Ok",
          );
        } else {
          CustomDialog.showMessage(
            context: context,
            title: "Error",
            message: e.response?.data['message'] ?? "Something went wrong!",
            posActionName: "Ok",
          );
        }
      } catch (e) {
        CustomDialog.hideLoading(context: context);
        CustomDialog.showMessage(
          context: context,
          title: "Error",
          message: "Unexpected error: $e",
          posActionName: "Ok",
        );
      }
    }
  }

  void loginGoogle() async {
    //todo show loading
    CustomDialog.showLoading(
      context: context,
      text: AppLocalizations.of(context)!.loading,
    );
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
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
        title: AppLocalizations.of(context)!.successfully,
        message: AppLocalizations.of(context)!.login_successfully,
        posActionName: AppLocalizations.of(context)!.ok,
        posActionClick: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeScreen,
          (route) => false,
          arguments: widget.loginToken,
        ),
      );
    } on Exception catch (e) {
      //todo hide loading
      CustomDialog.hideLoading(context: context);
      //todo show message error
      CustomDialog.showMessage(
        context: context,
        title: AppLocalizations.of(context)!.error,
        message: e.toString(),
        posActionName: AppLocalizations.of(context)!.ok,
      );
    }
  }
}
