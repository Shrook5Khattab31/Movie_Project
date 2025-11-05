import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/appColors.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback onPressed;
  Widget child;
  Color color ;
  CustomElevatedButton({super.key, required this.onPressed,
    required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: height*0.02),
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
              , side: BorderSide(color: AppColors.secondColor, width: 2) )
      ),
      child: child,
    );
  }
}
