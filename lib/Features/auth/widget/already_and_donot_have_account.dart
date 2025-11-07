import 'package:flutter/material.dart';
import 'package:movie_project/core/theme/appStyles.dart';
import 'package:movie_project/core/widgets/custom_text_button.dart';

class AlreadyAndDonotHaveAccount extends StatelessWidget {
  const AlreadyAndDonotHaveAccount({
    super.key,
    required this.text,
    required this.textButton,
    required this.onPressedButton,
  });
  final String text;
  final String textButton;
  final  void Function() onPressedButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style:AppStyles.reg14White,
        ),
        CustomTextButton(
            text: textButton,
            onPressed: onPressedButton,
            styleText: AppStyles.bla14Yellow)
      ],
    );
  }
}
