import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/user.dart';
import 'package:belove_app/data/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/services/auth.dart';
import '../../../../generated/l10n.dart';

class SignUpBloc {
  SignUpBloc._();

  static final ins = SignUpBloc._();

  //DATA==============================
  String? password;
  String? email;

  //EVENTS=====================================

  void validateSignUpForm(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      signUpWithEmail();
    }
  }

  dynamic validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return S.current.enteryouremail;
    }
    email = val;
    return null;
  }

  dynamic validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return S.current.enteryourpass;
    } else if (val.length < 6) {
      return S.current.mustbe6;
    }
    password = val;
    return null;
  }

  dynamic validateRePass(String? val) {
    if (val == null || val.isEmpty) {
      return S.current.enteryourpass;
    }
    if (val != password) {
      return S.current.incorrectpassword;
    }
    return null;
  }

  signUpWithEmail() async {
    EasyLoading.show();
    User? res = await AuthService.ins
        .signUpWithEmailPassword(email: email!, password: password!);
    EasyLoading.dismiss();
    if (res != null) {
      EasyLoading.dismiss();
      await DataBaseService.ins.uploadUserInfo(res);
      GlobalData.ins.currentUser = res;
      EasyLoading.dismiss();
    }
  }

  void dispose() {
    email = null;
    password = null;
  }
}
