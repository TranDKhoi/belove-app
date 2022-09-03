import 'dart:async';
import 'dart:io';

import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/data/models/anniversary.dart';
import 'package:belove_app/data/services/database/anniversary_base.dart';
import 'package:belove_app/data/services/database/chat_base.dart';
import 'package:belove_app/data/services/database/timeline_base.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../data/models/user.dart';
import '../../../data/services/database/user_base.dart';
import '../../../data/services/store.dart';
import '../../../generated/l10n.dart';
import '../../core/utils/utils.dart';
import '../../global_data/global_data.dart';
import '../../global_data/global_key.dart';

class ProfileBloc {
  //=========================================
  final StreamController<String> _avatarStreamController =
      StreamController<String>();

  Stream<String> get avatarStream => _avatarStreamController.stream;

  final StreamController<String> _birthdayStreamController =
      StreamController<String>();

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
    String? path = await ImageHelper.ins.pickAvatar();
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
      await UserBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
      _avatarStreamController.sink.add(imgLink);
    }
  }

  uploadBirthDay() async {
    if (birthDay == null) return;
    GlobalData.ins.currentUser!.birthday = birthDay;
    await UserBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
    _birthdayStreamController.sink.add(dateFormat(birthDay!));
  }

  Future<User?> findPartner(String pId) async {
    if (pId == GlobalData.ins.currentUser!.userId) return null;
    User? res = await UserBaseService.ins.getUserById(pId);
    if (res == null || res.name == "") {
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
      User partner = await UserBaseService.ins.getUserById(id);

      if (partner.gender == GlobalData.ins.currentUser!.gender) {
        EasyLoading.showToast(S.current.youguysareofthesamegender);
        return;
      }

      partner.partnerId = GlobalData.ins.currentUser!.userId;
      GlobalData.ins.currentUser!.partnerId = id;
      GlobalData.ins.currentUser!.partner = partner;

      EasyLoading.show();
      await UserBaseService.ins.uploadUserInfo(GlobalData.ins.currentUser!);
      await UserBaseService.ins.uploadUserInfo(partner);
      await TimelineBaseService.ins.createTimeLineCollection();
      await AnniversaryBaseService.ins.createAnniversaryCollection();
      await AnniversaryBaseService.ins.uploadAnniversary(
          Anniversary(title: partner.name, date: partner.birthday));
      await AnniversaryBaseService.ins.uploadAnniversary(Anniversary(
          title: GlobalData.ins.currentUser!.name,
          date: GlobalData.ins.currentUser!.birthday));
      await ChatBaseService.ins.createChatRoom();
      navigatorKey.currentState?.pop();
      navigatorKey.currentState?.pop();
      _partnerStreamController.sink.add(partner);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }
}
