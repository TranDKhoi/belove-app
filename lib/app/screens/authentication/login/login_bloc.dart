import 'package:belove_app/app/route.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/global_key.dart';

class LoginBloc {
  LoginBloc._();

  static final ins = LoginBloc._();

  void loginWithEmailPass({required String email, required String password}) {
    if (!email.isNotEmpty || !password.isNotEmpty) {
      EasyLoading.showToast(S.current.pleaseenteryouremailorpassword);
      return;
    }
    navigatorKey.currentState
        ?.pushNamed(wrapperScreen, arguments: "this is datasss");
  }

  void dispose() {}
}
