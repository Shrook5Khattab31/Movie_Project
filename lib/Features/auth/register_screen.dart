import 'package:flutter/material.dart';
import 'package:movie_project/Features/auth/widget/built_avatar_register.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/core/widgets/custom_language_switch_button.dart';
import 'package:movie_project/core/widgets/custom_text_form_field.dart';
import '../../api/api_service.dart';
import '../../core/utils/custom_dialog.dart';
import '../../l10n/app_localizations.dart';
import 'widget/already_and_donot_have_account.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
ApiService apiService=ApiService();
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
  int selectedAvatarId = 1;
  bool showPassword = true;
  bool showConfirmPassword = true;
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
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_sharp,
            color: AppColors.secondColor,),
        ),
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
                  BuiltAvatarRegister(
                    onAvatarChanged: (index) {
                    selectedAvatarId = index;
                  },),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.name,
                    hintStyle: AppStyles.reg16White,
                    controller: nameController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Image.asset(AppImages.userIcon),
                    prefixIconColor: AppColors.whiteColor,
                    validatorFunc: (text) {
                      if(text==null || text.trim().isEmpty){
                        return"What's your name?";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.email,
                    hintStyle: AppStyles.reg16White,
                    controller: emailController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Image.asset(AppImages.emailIcon),
                    prefixIconColor: AppColors.whiteColor,
                    keyboardType: TextInputType.emailAddress,
                      validatorFunc:(text) {
                        if(text==null || text.trim().isEmpty){
                          return'Please Enter your Email';
                        }
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if(!emailValid){
                          return 'Please Enter valid Email';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextFormField(
                    hintText: language.password,
                    hintStyle: AppStyles.reg16White,
                    controller: passwordController,
                    fillColor: AppColors.grayDarkColor,
                    prefixIcon: Image.asset(AppImages.passwordIcon),
                    prefixIconColor: AppColors.whiteColor,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: showPassword,
                    suffixIconColor: AppColors.whiteColor,
                    validatorFunc:(text) {
                      if(text==null || text.trim().isEmpty){
                        return'Please Enter Password';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
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
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: showConfirmPassword,
                    suffixIconColor: AppColors.whiteColor,
                    suffixIcon: IconButton(
                      onPressed: () {
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
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 0.024 * height),
                  CustomElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        CustomDialog.showMessage(
                          context: context,
                          background: AppColors.primaryColor,
                          styleMessage: AppStyles.bold14Yellow,
                          message: 'Waiting...',
                        );

                        try {
                          var response = await apiService.registerUser(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            phone: phoneController.text,
                            avaterId: selectedAvatarId,
                          );

                          CustomDialog.hideLoading(context: context);

                          if ((response.data['message'] == "User created successfully" &&
                              response.data['data'] != null) ) {
                            CustomDialog.showMessage(
                              context: context,
                              background: AppColors.primaryColor,
                              styleMessage: AppStyles.bold20Yellow,
                              message: 'Register successfully ',
                            );
                            await Future.delayed(const Duration(seconds: 2));
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.login,
                                  (route) => false,
                            );
                          }
                          else if (response.data['message']
                              .toString()
                              .contains("Phone")) {

                            CustomDialog.showMessage(
                              context: context,
                              background: AppColors.primaryColor,
                              styleMessage: AppStyles.bold14Yellow,
                              message: "Please make sure the phone number starts with +20 and contains 11 number",
                              title: "Error",
                              posActionName: "ok",
                            );
                          }

                          else {
                            String message = response.data['message'].toString();
                            CustomDialog.showMessage(
                              context: context,
                              background: AppColors.primaryColor,
                              styleMessage: AppStyles.bold14Yellow,
                              message: message,
                              title: "Error",
                              posActionName: "ok",

                            );
                          }
                        } catch (e) {
                          CustomDialog.hideLoading(context: context);
                          CustomDialog.showMessage(
                            context: context,
                            background: AppColors.primaryColor,
                            styleMessage: AppStyles.bold14Yellow,
                            message: 'Something went wrong ',
                          );
                        }
                      }

                    },
                    backgroundColor: AppColors.secondColor,
                    text: language.create_acc,
                    textStyle: AppStyles.reg20Black,
                  ),
                  SizedBox(height: 0.02 * height),
                  AlreadyAndDonotHaveAccount(
                    text: '${language.already_have_acc} ?',
                    textButton: language.login,
                    onPressedButton: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                  ),
                  SizedBox(height: 0.01 * height),
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
