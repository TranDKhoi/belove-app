import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/user.dart';
import 'package:belove_app/data/services/auth.dart';
import 'package:belove_app/data/services/database/user_base.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/services/database/anniversary_base.dart';
import '../../../../generated/l10n.dart';
import '../../../global_data/global_key.dart';
import '../../../route.dart';
import '../../chat/chat_bloc.dart';

class LoginBloc {
  void loginWithEmailPass(
      {required String email, required String password}) async {
    //validate
    if (!email.isNotEmpty || !password.isNotEmpty) {
      EasyLoading.showToast(S.current.pleaseenteryouremailorpassword);
      return;
    }

    //sign in
    EasyLoading.show();
    User? res = await AuthService.ins
        .signInWithEmailPassword(email: email, password: password);
    EasyLoading.dismiss();

    //get user by id
    if (res != null) {
      User? u = await UserBaseService.ins.getUserById(res.userId!);
      if (u != null) {
        GlobalData.ins.currentUser = u;
        if (u.name == "") {
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil(bioScreen, (_) => false);
          return;
        }
        await fetchUserData();
        ChatBloc.ins.listenToMessage();
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil(bottomBarScreen, (_) => false);
      }
    }
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
            break;
          }
        }
      }
    }

    //save to local
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userId", GlobalData.ins.currentUser!.userId!);
  }
}
