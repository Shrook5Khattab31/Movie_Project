import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/core/constants/appAssets.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_elevated_btn.dart';
import 'package:movie_project/core/widgets/custom_text_form_field.dart';
import 'package:movie_project/l10n/app_localizations.dart';

import '../../../../api/api_service.dart';
import '../../../../core/utils/custom_dialog.dart';

class ResetPassword extends StatefulWidget{
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late var args;
  //var formKey = GlobalKey<FormState>();
  bool isNotVisible = true;
  TextEditingController oldPassController = TextEditingController();

  TextEditingController newPassController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    args = (ModalRoute.of(context)!.settings.arguments ??'') as String;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        title:Text(AppLocalizations.of(context)!.reset_password
          ,style: AppStyles.reg16Yellow,),
        centerTitle: true,
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
          padding:EdgeInsets.symmetric(horizontal: width*0.04),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(AppImages.forgotPasswordImage),
              CustomTextFormField(
                controller: oldPassController,
                prefixIcon:Image.asset( AppImages.passwordIcon),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: AppLocalizations.of(context)!.old_password,
                hintStyle: AppStyles.reg16White,
                validatorFunc: (text){
                  if(text == null || text.trim().isEmpty){
                    return "Old password shouldn't be null";
                  }
                  return null;
                },
              ),
              SizedBox(height: height*0.02,),
              CustomTextFormField(
                controller: newPassController,
                prefixIcon:Image.asset( AppImages.passwordIcon),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: AppLocalizations.of(context)!.new_password,
                hintStyle: AppStyles.reg16White,
                validatorFunc: (text){
                  RegExp regex = RegExp(r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}$');
                  if(text == null || text.trim().isEmpty){
                    return "New password shouldn't be null";
                  } else if(text.length < 8){
                    return "Password should at least 8 characters";
                  }
                  else if(!regex.hasMatch(text)){
                    return "Password should contains at least one upper letter,\n one lower letter, \n one digit and \none special character";
                  }
                  return null;
                },
              ),
              SizedBox(height: height*0.02,),
              CustomTextFormField(
                controller: confirmPassController,
                prefixIcon:Image.asset( AppImages.passwordIcon),
                suffixIcon: Icon(Icons.visibility_off),
                hintText: AppLocalizations.of(context)!.rewrite_password,
                hintStyle: AppStyles.reg16White,
                validatorFunc: (text){
                  if(text == null || text.trim().isEmpty){
                    return "Password shouldn't be null";
                  }
                  if(text != newPassController.text){
                    return "Password doesn't much";
                  }
                  return null;
                },
              ),
              SizedBox(height: height*0.05,),
              SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: () {
                        resetPassword();
                    },
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
  void resetPassword() async{
    try {
      CustomDialog.showLoading(context: context,
          background: AppColors.primaryColor, text: "Loading ...", style: AppStyles.bold20Yellow);
      var response = await ApiService().resetPassword(oldPassword: oldPassController.text,
          newPassword: newPassController.text, token: args);
      if( response.data['message'] == "Password updated successfully"){
        CustomDialog.hideLoading(context: context);
        CustomDialog.showMessage(context: context, styleMessage: AppStyles.bold14Yellow,
            message: "Password updated successfully", posActionName: "Ok");
      }
    } on DioException catch(e){
      CustomDialog.hideLoading(context: context);
      if(e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.connectionError
          || e.type == DioExceptionType.connectionTimeout){
        CustomDialog.showMessage(context: context, styleMessage: AppStyles.bold14Yellow,
            message: "Network error, please try again!", posActionName: "Ok"
        );
      }
      else if(e.response!.statusCode == 400){
        CustomDialog.showMessage(context: context, styleMessage: AppStyles.bold14Yellow,
            message: "Old password doesn't much!", posActionName: "Ok"
        );
      } else {
        CustomDialog.showMessage(context: context, styleMessage: AppStyles.bold14Yellow,
            message: "something went Wrong!", posActionName: "Ok"
        );
      }
    }
    catch(e){
      CustomDialog.showMessage(context: context, styleMessage: AppStyles.bold14Yellow,
          message: "Unexpected error!", posActionName: "Ok"
      );

    }
  }
}