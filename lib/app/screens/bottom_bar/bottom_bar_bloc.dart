import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/database/anniversary_base.dart';
import '../../../data/services/database/user_base.dart';
import '../../global_data/global_data.dart';

class BottomBarBloc {
  BottomBarBloc._();

  static final ins = BottomBarBloc._();

  //============================================
  final StreamController<int> _currentPageController =
      StreamController<int>.broadcast();

  Stream<int> get currentPageStream => _currentPageController.stream;

  //==============================================

  changeCurrentPage(int i) {
    _currentPageController.sink.add(i);
  }

  fetchUserData() async {
    if (GlobalData.ins.currentUser!.partnerId != "") {
      GlobalData.ins.currentUser!.partner = await UserBaseService.ins
          .getUserById(GlobalData.ins.currentUser!.partnerId!);

      //set ourDay
      var res = await AnniversaryBaseService.ins.getAnniversary();
      if (res != null) {
        for (int i = 0; i < res.length; i++) {
          if (res[i].title == " years anniversary") {
            GlobalData.ins.ourDay = res[i];
          }
          break;
        }
      }
    }

    //save to local
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userId", GlobalData.ins.currentUser!.userId!);
  }

  void dispose() {
    _currentPageController.close();
  }
}
