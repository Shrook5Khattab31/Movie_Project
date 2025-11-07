import 'package:flutter/material.dart';
import 'package:movie_project/core/theme/appColors.dart';
import 'package:movie_project/core/theme/appStyles.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final bool? haveIcon;
  final Image? icon;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    this.textStyle,
   this.haveIcon,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:(haveIcon ?? false)?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
            style: textStyle??textStyle??AppStyles.semiBold20Black,
            ),
          const SizedBox(width: 8),
          if (icon != null) icon!,
          ],
        ):
        Text(
          text,
          style: textStyle??AppStyles.semiBold20Black,
        ),
      ),
    );
  }
}