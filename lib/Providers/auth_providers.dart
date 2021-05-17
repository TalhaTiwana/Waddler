
import 'dart:io';

import 'package:flutter/material.dart';

class AUthProvider extends ChangeNotifier{
  String loginError;
  String signUpError;
  File imageFileParent;
  File imageFileChild;
  String loginErrorGet()=>loginError;
  String signUpErrorGet()=>signUpError;
  File imageFileGet()=>imageFileParent;
  File imageFileChildGet()=>imageFileChild;

  loginErrorSet(String error){
    this.loginError = error;
    notifyListeners();
  }

  imageFileSet(File file){
    this.imageFileParent = file;
    notifyListeners();
  }

  imageFileChildSet(File file){
    this.imageFileChild = file;
    notifyListeners();
  }

  signUpErrorSet(String error){
    notifyListeners();
    this.signUpError = error;
  }

}
