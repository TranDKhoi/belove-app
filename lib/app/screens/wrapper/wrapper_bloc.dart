import 'dart:async';

import 'package:belove_app/app/global_data/global_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/user.dart';
import '../../../data/services/database.dart';

class WrapperBloc {
  WrapperBloc._();

  static final ins = WrapperBloc._();

  //============================================
  final StreamController<int> _currentPageController =
      StreamController<int>.broadcast();

  Stream<int> get currentPageStream => _currentPageController.stream;

  //==============================================

  changeCurrentPage(int i) {
    _currentPageController.sink.add(i);
  }

  getUserData() async {
    if (GlobalData.ins.currentUser!.partnerId != "") {
      User partner = await DataBaseService.ins
          .getUserById(GlobalData.ins.currentUser!.partnerId!);
      GlobalData.ins.currentUser!.partner = partner;
      GlobalData.ins.ourDay = await DataBaseService.ins.getAnniversary();
    }

    //save to local
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userId", GlobalData.ins.currentUser!.userId!);
  }

  void dispose() {
    _currentPageController.close();
  }
}
