import 'package:flutter/material.dart';

class LangProvider extends ChangeNotifier{
  String appLang = 'en';
  void changeLang(String newLang){
    if(newLang == appLang) return;
    appLang = newLang;
    notifyListeners();
  }
}