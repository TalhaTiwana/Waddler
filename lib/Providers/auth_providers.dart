import 'package:flutter/material.dart';

class AUthProvider extends ChangeNotifier{
  String loginError;
  String signUpError;

  String loginErrorGet()=>loginError;
  String signUpErrorGet()=>signUpError;


  loginErrorSet(String error){
    notifyListeners();
    this.loginError = error;
  }

  signUpErrorSet(String error){
    notifyListeners();
    this.signUpError = error;
  }

}
