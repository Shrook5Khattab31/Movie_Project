import 'package:flutter/material.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final language=AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(language.register, style: AppStyles.reg16Yellow),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.040 * width,
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
                      prefixIcon:Icon(Icons.person),
                      prefixIconColor: AppColors.whiteColor,
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.email,
                    hintStyle: AppStyles.reg16White,
                    controller: emailController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon:Icon(Icons.email),
                    prefixIconColor: AppColors.whiteColor,
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.password,
                    hintStyle: AppStyles.reg16White,
                    controller: passwordController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon:Icon(Icons.lock),
                    prefixIconColor: AppColors.whiteColor,
                    isPassword: true,
                    suffixIconColor: AppColors.whiteColor ,
                    suffixIcon: Icon(Icons.visibility),
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.confirm_password,
                    hintStyle: AppStyles.reg16White,
                    controller: confirmPasswordController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon:Icon(Icons.lock),
                    prefixIconColor: AppColors.whiteColor,
                    isPassword: true,
                    suffixIconColor: AppColors.whiteColor ,
                    suffixIcon: Icon(Icons.visibility),
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.phone_number,
                    hintStyle: AppStyles.reg16White,
                    controller: phoneController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon:Icon(Icons.phone),
                    prefixIconColor: AppColors.whiteColor,
                  ),
                  SizedBox(height: 0.024 * height),
                  CustomElevatedButton(
                      onPressed:  () {
                        //todo logic signup
                        },
                      color:  AppColors.secondColor,
                      child: Text(language.create_acc,style: AppStyles.reg20Black,),
                  ),
                  SizedBox(height: 0.02 * height),
                  AlreadyAndDonotHaveAccount(
                    text: language.already_have_acc,
                    textButton: language.login,
                    onPressedButton: () {
                      //todo nav into login
                    },
                  ),
                  SizedBox(height: 0.02 * height),
                  //todo change language toggle
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
