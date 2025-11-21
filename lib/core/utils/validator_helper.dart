
class ValidatorHelper{
  static String? validateName(String? text){
      if(text==null || text.trim().isEmpty){
        return"What's your name?";
      }
    return null;
  }

  static String? validateEmail(String? text){
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

  static String? validatePassword(String? text){
    if(text==null || text.trim().isEmpty){
      return'Please Enter Password';
    }
    return null;
  }

  static String? validateConfirmPassword(String? text){
    if(text==null || text.trim().isEmpty){
      return'Please Enter Confirm Password';
    }
    return null;
  }
}