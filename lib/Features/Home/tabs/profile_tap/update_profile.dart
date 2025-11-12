import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/routing/routeNames.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/core/widgets/custom_text_button.dart';
import 'package:movie_project/core/widgets/custom_text_form_field.dart';
import '../../../../core/theme/appColors.dart';
import '../../../../core/theme/appStyles.dart';
import '../../../../core/utils/custom_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dio/dio.dart';

import '../../../auth/register_screen.dart';

class UpdateProfile extends StatefulWidget {
   UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final List<String> avatars = [
    AppImages.avatar1, AppImages.avatar2, AppImages.avatar3,
    AppImages.avatar4, AppImages.avatar5, AppImages.avatar6,
    AppImages.avatar7, AppImages.avatar8, AppImages.avatar9
  ];

  String selectedAvatar = AppImages.avatar1;
  final TextEditingController emailController = TextEditingController(text: "mai@gmail.com");
  final TextEditingController phoneController = TextEditingController(text: "01274929396");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.reg16Yellow,
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_sharp, color: AppColors.secondColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: height * 0.03),
              GestureDetector(
                onTap: () => showAvatars(context),
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.01),
                  child: Image.asset(selectedAvatar, height: height * 0.12),
                ),
              ),
              CustomTextFormField(
                controller: emailController,
                prefixIcon: Icon(Icons.person),
                hintText: AppLocalizations.of(context)!.email,
                hintStyle: AppStyles.reg16White,
                validatorFunc: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return "Please enter an Email";
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.015),
              CustomTextFormField(
                controller: phoneController,
                hintText: AppLocalizations.of(context)!.phone_number,
                hintStyle: AppStyles.reg16White,
                fillColor: AppColors.grayDarkColor,
                prefixIcon: Icon(Icons.phone),
                prefixIconColor: AppColors.whiteColor,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: height * 0.015),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextButton(
                  text: AppLocalizations.of(context)!.reset_password,
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.resetPassScreen),
                  styleText: AppStyles.reg20White,
                ),
              ),
              Expanded(child: SizedBox()),
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.delete_account,
                textStyle: AppStyles.reg20White,
                onPressed: () {
                  // هنا تضيفي API call للحذف مع widget.loginToken
                },
                backgroundColor: AppColors.redColor,
              ),
              SizedBox(height: height * 0.01),
              CustomElevatedButton(
                text: AppLocalizations.of(context)!.update_data,
                textStyle: AppStyles.reg20Black,
                backgroundColor: AppColors.secondColor,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    CustomDialog.showMessage(
                      context: context,
                      background: AppColors.primaryColor,
                      styleMessage: AppStyles.bold14Yellow,
                      message: 'Waiting...',
                    );

                    try {
                      Response response = await apiService.updateProfile(
                        email: emailController.text,
                        avatarId: avatars.indexOf(selectedAvatar) + 1,
                        //todo add token here
                        token: args,
                      );
                      //todo add token here
                      print('token update: ${args}');
                      CustomDialog.hideLoading(context: context);

                      if (response.data['message'] == "Profile updated successfully") {
                        CustomDialog.showMessage(
                          context: context,
                          background: AppColors.primaryColor,
                          styleMessage: AppStyles.bold20Yellow,
                          message: 'Profile updated successfully',
                          posActionName: 'ok'
                        );
                      } else {
                        CustomDialog.showMessage(
                          context: context,
                          background: AppColors.primaryColor,
                          styleMessage: AppStyles.bold14Yellow,
                          message: response.data['message'].toString(),
                          title: "Error",
                          posActionName: "ok",
                        );
                      }
                    } catch (e) {
                      // 5. Exception
                      CustomDialog.hideLoading(context: context);
                      CustomDialog.showMessage(
                        context: context,
                        background: AppColors.primaryColor,
                        styleMessage: AppStyles.bold14Yellow,
                        message: 'Something went wrong',
                      );
                    }
                  }
                },
              ),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showAvatars(BuildContext context) async {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparentColor,
      builder: (context) {
        return Container(
          height: height * 0.46,
          padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: width * 0.04),
          decoration: BoxDecoration(
            color: AppColors.grayDarkColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: GridView.builder(
            itemCount: avatars.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: width * 0.02,
              mainAxisSpacing: height * 0.02,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatars[index];
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.02),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(avatars[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        );
      },
    );
  }
}