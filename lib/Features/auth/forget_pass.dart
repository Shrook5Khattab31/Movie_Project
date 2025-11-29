import 'package:flutter/material.dart';

import '../../core/constants/appAssets.dart';
import '../../core/theme/appColors.dart';
import '../../core/theme/appStyles.dart';
import '../../core/widgets/custom_elevated_btn.dart';
import '../../core/widgets/custom_text_form_field.dart';
import '../../l10n/app_localizations.dart';
import '../Home/tabs/profile_tap/resetPassword.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.forget_password,
          style: AppStyles.reg16Yellow,
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_sharp,
            color: AppColors.secondColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              Image.asset(AppImages.forgotPasswordImage),
              SizedBox(height: height * 0.03),
              SizedBox(
                height: height * 0.06,
                child: CustomTextFormField(
                  controller: emailController,
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.visibility_off),
                  hintText: AppLocalizations.of(context)!.email,
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                height: height * 0.06,
                child: CustomElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPassword(),
                        settings: RouteSettings(arguments: ""),
                      ),
                    );
                  },
                  text: AppLocalizations.of(context)!.verify_email,
                  backgroundColor: AppColors.secondColor,
                  textStyle: AppStyles.reg20Black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}