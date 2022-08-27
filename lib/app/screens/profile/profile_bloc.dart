import 'dart:async';
import 'dart:io';

import 'package:belove_app/app/global_data/global_key.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../data/models/user.dart';
import '../../../data/services/database.dart';
import '../../../data/services/store.dart';
import '../../../generated/l10n.dart';
import '../../core/utils/utils.dart';
import '../../global_data/global_data.dart';
import '../../global_data/global_key.dart';

class ProfileBloc {
  ProfileBloc._();

  static final ins = ProfileBloc._();

  //=========================================
  final StreamController<String> _avatarStreamController =
      StreamController<String>.broadcast();

  Stream<String> get avatarStream => _avatarStreamController.stream;

  final StreamController<String> _birthdayStreamController =
      StreamController<String>.broadcast();

  Stream<String> get birthDayStream => _birthdayStreamController.stream;

  final StreamController<User> _partnerStreamController =
      StreamController<User>.broadcast();

  Stream<User> get partnerStream => _partnerStreamController.stream;

  //=======================================================

  DateTime? birthDay;

  //======================================================
  void dispose() {
    _birthdayStreamController.close();
    _partnerStreamController.close();
    _avatarStreamController.close();
    birthDay = null;
  }

  void changeAvatar() async {
    EasyLoading.show();
    String? path = await ImageHelper.ins.pickImage();
    if (path != null) {
      await uploadAvatar(path);
    }
    EasyLoading.dismiss();
  }

  uploadAvatar(String img) async {
    final File imageFile = File(img);

    var imgLink = await StoreService.ins.uploadUserAvatar(imageFile);
    if (imgLink != null) {
      GlobalData.ins.currentUser!.avatar = imgLink;
      DataBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
      _avatarStreamController.sink.add(imgLink);
    }
  }

  uploadBirthDay(DateTime newDate) async {
    GlobalData.ins.currentUser!.birthday = newDate;
    await DataBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
    _birthdayStreamController.sink.add(dateFormat(newDate));
  }

  Future<User?> findPartner(String pId) async {
    if (pId == GlobalData.ins.currentUser!.userId) return null;
    User? res = await DataBaseService.ins.getUserById(pId);
    if (res == null) {
      EasyLoading.showToast(S.current.usernotfound);
      return null;
    }
    if (res.partnerId != "") {
      EasyLoading.showToast(S.current.findsomeonewhoissingle);
      return null;
    }
    return res;
  }

  connectPartner(String id) async {
    try {
      EasyLoading.show();
      User partner = await DataBaseService.ins.getUserById(id);
      partner.partnerId = GlobalData.ins.currentUser!.userId;
      GlobalData.ins.currentUser!.partnerId = id;
      GlobalData.ins.currentUser!.partner = partner;

      await DataBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
      await DataBaseService.ins.uploadUserInfo(partner);
      navigatorKey.currentState?.pop();
      navigatorKey.currentState?.pop();
      print(partner.name!);
      _partnerStreamController.sink.add(partner);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }
}
