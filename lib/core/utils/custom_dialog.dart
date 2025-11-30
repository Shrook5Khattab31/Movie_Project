import 'package:flutter/material.dart';
import '../theme/appColors.dart';
import '../theme/appStyles.dart';

class CustomDialog {
  static void showLoading({
    required BuildContext context,
    required String text,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          title: Row(
            spacing: 18,
            children: [
              CircularProgressIndicator(color: AppColors.secondColor),
              Text(text, style: AppStyles.bold20Yellow,),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String title,
    required String message,
    String? posActionName,
    Function? posActionClick,
    String? nagActionName,
    Function? nagActionClick,
  }) {
    List<Widget>? actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posActionClick?.call();
          },
          child: Text(posActionName, style: AppStyles.bold20Yellow),
        ),
      );
    }
    if (nagActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            nagActionClick?.call();
          },
          child: Text(nagActionName, style: AppStyles.bold20Yellow),
        ),
      );
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          title: Text(title, style: AppStyles.bold20Yellow),
          content: Text(message, style: AppStyles.reg16White),
          actions: actions,
        );
      },
    );
  }
}
