import 'dart:async';

import 'package:belove_app/app/global_data/global_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SupportedLanguage {
  vietnamese,
  english,
}

class MyAppBloc {
  MyAppBloc._();
  static final ins = MyAppBloc._();

  //STREAM CONTROLLER====================================================
  final StreamController<String> _languageStreamController =
      StreamController<String>.broadcast();

  Stream<String> get languageStream => _languageStreamController.stream;

  final StreamController<bool> _darkModeStreamController =
      StreamController<bool>.broadcast();

  Stream<bool> get darkModeStream => _darkModeStreamController.stream;

  //DATA===================================================================
  SupportedLanguage currentLang = SupportedLanguage.english;

  //EVENT==============================================================
  void changeLanguage(SupportedLanguage lang) async {
    SharedPreferences ref = await SharedPreferences.getInstance();

    switch (lang) {
      case SupportedLanguage.english:
        {
          GlobalData.ins.currentLang = "en";
          ref.setString("language", "en");
          _languageStreamController.sink.add("en");
          return;
        }
      case SupportedLanguage.vietnamese:
        {
          GlobalData.ins.currentLang = "vi";
          ref.setString("language", "vi");
          _languageStreamController.sink.add("vi");
          return;
        }
    }
  }

  changeDarkMode(val) async {
    var ref = await SharedPreferences.getInstance();
    ref.setBool("isDark", val);
    GlobalData.ins.isDark = val;
    _darkModeStreamController.sink.add(val);
  }

  void dispose() {
    _darkModeStreamController.close();
    _languageStreamController.close();
  }
}
