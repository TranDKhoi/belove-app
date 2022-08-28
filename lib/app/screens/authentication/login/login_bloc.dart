import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/user.dart';
import 'package:belove_app/data/services/auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/services/database.dart';
import '../../../../generated/l10n.dart';
import '../../../global_data/global_key.dart';
import '../../../route.dart';

class LoginBloc {
  LoginBloc._();

  static final ins = LoginBloc._();

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

    //get user data by id
    if (res != null) {
      User? u = await DataBaseService.ins.getUserById(res.userId!);
      if (u != null) {
        GlobalData.ins.currentUser = u;

        if (u.name == "") {
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil(bioScreen, (_) => false);
          return;
        }
        if (u.partnerId != "") {
          User partner = await DataBaseService.ins.getUserById(u.partnerId!);
          GlobalData.ins.currentUser!.partner = partner;
          GlobalData.ins.ourDay = await DataBaseService.ins.getAnniversary();
        }
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil(wrapperScreen, (_) => false);
      }
    }
  }

  void dispose() {}
}
