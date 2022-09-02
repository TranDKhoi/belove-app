import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/bottom_bar/bottom_bar_bloc.dart';
import 'package:belove_app/data/services/database/user_base.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/global_data/global_data.dart';
import 'app/screens/my_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configEasyLoading();
  await initData();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

initData() async {
  await Firebase.initializeApp();
  var pref = await SharedPreferences.getInstance();

  var res = pref.getString("userId");

  if (res != null) {
    GlobalData.ins.currentUser = await UserBaseService.ins.getUserById(res);
    if (GlobalData.ins.currentUser!.partnerId != "") {
      await BottomBarBloc.ins.fetchUserData();
    }
  }

  GlobalData.ins.isDark = pref.getBool("isDark") ?? false;

  var lang = pref.getString("language");
  if (lang != null) {
    GlobalData.ins.currentLang = lang;
  }
}
