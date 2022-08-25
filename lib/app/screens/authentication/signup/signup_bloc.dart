import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../generated/l10n.dart';

class SignUpBloc {
  SignUpBloc._();

  static final ins = SignUpBloc._();

  //DATA==============================
  String? password;

  //EVENTS=====================================

  void validateSignUpForm(GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      EasyLoading.showToast("ok rof");
    }
  }

  dynamic validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return S.current.enteryouremail;
    }
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

  void dispose() {}
}
