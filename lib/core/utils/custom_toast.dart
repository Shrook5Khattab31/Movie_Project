import 'package:fluttertoast/fluttertoast.dart';
import '../theme/appColors.dart';

class CustomToast {
  static void showToast({
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.secondColor,
      fontSize:22,
    );
  }
}
