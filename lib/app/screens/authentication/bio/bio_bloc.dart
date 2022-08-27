import 'dart:async';

import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/data/services/database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../generated/l10n.dart';

class BioBloc {
  BioBloc._();

  static final ins = BioBloc._();

  //STREAM=======================================
  final StreamController<String> _birthdayStreamController =
      StreamController<String>();

  Stream<String> get birthDayStream => _birthdayStreamController.stream;

  final StreamController<int> _genderStreamController = StreamController<int>();

  Stream<int> get genderStream => _genderStreamController.stream;

  //DATA==========================================
  String? name;
  DateTime? birthDay;
  int? gender = 0;

  validateBioForm(GlobalKey<FormState> key) {
    if (birthDay == null) {
      EasyLoading.showToast(S.current.enteryourbirthday);
      return;
    }
    if (key.currentState!.validate()) {
      uploadUserInfo();
    }
  }

  validateName(String? val) {
    if (val == null || val.isEmpty) {
      return S.current.pleaseenteryourname;
    }
    name = val;
    return null;
  }

  uploadBirthDay(DateTime newDate) async {
    GlobalData.ins.currentUser!.birthday = newDate;
    await DataBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
    _birthdayStreamController.sink.add(dateFormat(newDate));
  }

  updateBirthDay(DateTime newDate) {
    birthDay = newDate;
    _birthdayStreamController.sink.add(dateFormat(newDate));
  }

  updateGender(int val) {
    gender = val;
    _genderStreamController.sink.add(val);
  }

  void dispose() {
    _genderStreamController.close();
    _birthdayStreamController.close();
    birthDay = null;
    name = null;
    gender = 0;
  }

  uploadUserInfo() async {
    EasyLoading.show();

    GlobalData.ins.currentUser!.gender = gender;
    GlobalData.ins.currentUser!.birthday = birthDay;
    GlobalData.ins.currentUser!.name = name;
    await DataBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
    GlobalData.ins.currentUser = await DataBaseService.ins
        .getUserById(GlobalData.ins.currentUser!.userId!);

    EasyLoading.dismiss();

    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        profileScreen, (_) => false,
        arguments: false);
  }
}
