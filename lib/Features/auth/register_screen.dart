import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/core/widgets/custom_language_switch_button.dart';
import 'package:movie_project/core/widgets/custom_text_form_field.dart';
import '../../l10n/app_localizations.dart';
import 'widget/already_and_donot_have_account.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool showPassword = false;
  bool showConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final language = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(language.register, style: AppStyles.reg16Yellow),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.045 * width,
              vertical: 0.02 * height,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //todo avatar
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.name,
                    hintStyle: AppStyles.reg16White,
                    controller: nameController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Image.asset(AppImages.userIcon),
                    prefixIconColor: AppColors.whiteColor,
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.email,
                    hintStyle: AppStyles.reg16White,
                    controller: emailController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Image.asset(AppImages.emailIcon),
                    prefixIconColor: AppColors.whiteColor,
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.password,
                    hintStyle: AppStyles.reg16White,
                    controller: passwordController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Image.asset(AppImages.passwordIcon),
                    prefixIconColor: AppColors.whiteColor,
                    isPassword: showPassword,
                    suffixIconColor: AppColors.whiteColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        //todo show password
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: showIconPassword(showPassword),
                    ),
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.confirm_password,
                    hintStyle: AppStyles.reg16White,
                    controller: confirmPasswordController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Image.asset(AppImages.passwordIcon),
                    prefixIconColor: AppColors.whiteColor,
                    isPassword: showConfirmPassword,
                    suffixIconColor: AppColors.whiteColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        //todo show confirm password
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                      icon: showIconPassword(showConfirmPassword),
                    ),
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.phone_number,
                    hintStyle: AppStyles.reg16White,
                    controller: phoneController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Icon(Icons.phone),
                    prefixIconColor: AppColors.whiteColor,
                  ),
                  SizedBox(height: 0.024 * height),
                  CustomElevatedButton(
                    onPressed: () {
                      //todo logic signup
                    },
                    color: AppColors.secondColor,
                    child: Text(
                      language.create_acc,
                      style: AppStyles.reg20Black,
                    ),
                  ),
                  SizedBox(height: 0.02 * height),
                  AlreadyAndDonotHaveAccount(
                    text: '${language.already_have_acc} ?',
                    textButton: language.login,
                    onPressedButton: () {
                      //todo nav into login
                    },
                  ),
                  SizedBox(height: 0.01 * height),
                  //todo change language toggle
                  Align(
                    alignment: Alignment.center,
                    child: CustomToggleSwitch(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget showIconPassword(bool show) {
  return Icon(show ? Icons.visibility_off_sharp : Icons.visibility);
}
