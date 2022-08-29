import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/data/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc {
  SettingBloc._();
  static final ins = SettingBloc._();

  //STREAM-------------------------------------------------------
  //-------------------------------------------------------------

  logOut() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    await AuthService.ins.signOut();
    ref.remove("userId");
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(mainAuthScreen, (_) => false);
  }

  void dispose() {}
}
