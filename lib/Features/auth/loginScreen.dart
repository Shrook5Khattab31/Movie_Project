import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_project/Features/auth/widget/already_and_donot_have_account.dart';
import 'package:movie_project/api/api_service.dart';
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
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: "mai@gmail.com");
  TextEditingController passController = TextEditingController(text: "Mai@1994");
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
                fit: BoxFit.fill,
                "assets/images/app_logo.png",
                width: width * 0.3,
                height: height * 0.13,
              ),

              CustomTextFormField(
                validatorFunc: (text){
                  if(text == null || text.trim().isEmpty){
                    return "Please enter an Email";
                  }
                  // final bool emailValid =
                  // RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(text);
                  // if (!emailValid) {
                  //   return "Please enter a valid Email";
                  // }
                  return null;
                },
                controller: emailController,
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: AppLocalizations.of(context)!.email,
                hintStyle: AppStyles.reg16White,
              ),
              CustomTextFormField(
                validatorFunc: (text){
                  if(text == null || text.trim().isEmpty){
                    return "Please enter a valid Password";
                  }
                  // final regx = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                  // .hasMatch(text);
                  // if(!regx){
                  //   return "Password must be equal or more than 8 characters "
                  //       "and contain Upper letters, lower lettrts, numbers and characters";
                  // }
                  return null;
                },
                isPassword: isVisible? false:true,
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock),
                hintText: AppLocalizations.of(context)!.password,
                suffixIcon: IconButton(onPressed: (){
                  //todo show pass
                  setState(() {
                    isVisible = !isVisible;
                  });
                }, icon: isVisible? Icon(Icons.visibility): Icon(Icons.visibility_off) ),
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
                    login();
                  },
                  text: AppLocalizations.of(context)!.login,
                  backgroundColor: AppColors.secondColor,
                  textStyle: AppStyles.reg20Black,
                ),
              ),
              AlreadyAndDonotHaveAccount(text: "${AppLocalizations.of(context)!.dont_have_acc} ?",
                  textButton: AppLocalizations.of(context)!.create_one, onPressedButton: (){
                    Navigator.pushNamed(context, AppRoutes.register);
                  }),
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
      ),
    );
  }
  void login() async{
    if (formKey.currentState?.validate() == true){
      CustomDialog.showLoading(context: context, background: AppColors.primaryColor,
          text: "Loading...", style: AppStyles.bold14Yellow);
      try{
        var response = await ApiService().signIn(email: emailController.text, password: passController.text);
        if(response.data['message'] == 'Success Login'){
          CustomDialog.hideLoading(context: context);
          CustomDialog.showMessage(context: context,
              styleMessage: AppStyles.bold14Yellow, message: "Login Successfully",
          posActionName: "Go to home", posActionClick: (){
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.homeScreen,
                      (route) => false,
                );
              }
          );

        }
      }
      on DioException catch(e){
        CustomDialog.hideLoading(context: context);
        if(e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout){
          CustomDialog.showMessage(context: context, background: AppColors.primaryColor,
              styleMessage: AppStyles.bold14Yellow, message: "Network error, please try again!"
          , posActionName: "Ok"
          );
        }
        else if(e.response!.statusCode==400){
          CustomDialog.showMessage(context: context, background: AppColors.primaryColor,
              styleMessage: AppStyles.bold14Yellow, message: "User is not found!, please try again",
          posActionName: "Ok"
          );
        }
        else {
          // Other server-side error
          CustomDialog.showMessage(
            context: context,
            background: AppColors.primaryColor,
            styleMessage: AppStyles.bold14Yellow,
            message: e.response?.data['message'] ?? "Something went wrong!",
            posActionName: "Ok",
          );
        }
      }
      catch (e) {
        CustomDialog.hideLoading(context: context);
        CustomDialog.showMessage(
          context: context,
          background: AppColors.primaryColor,
          styleMessage: AppStyles.bold14Yellow,
          message: "Unexpected error: $e",
          posActionName: "Ok",
        );
      }
    }
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
