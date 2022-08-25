import 'dart:async';

enum SupportedLanguage {
  vietnamese,
  english,
}

class MyAppBloc {
  //singleton
  MyAppBloc._();
  static final ins = MyAppBloc._();

  //STREAM CONTROLLER====================================================
  final StreamController<String> _languageState =
      StreamController<String>.broadcast();
  Stream<String> get languageStream => _languageState.stream;

  //DATA===================================================================
  SupportedLanguage currentLang = SupportedLanguage.english;

  //EVENT==============================================================
  void changeLanguage(SupportedLanguage lang) {
    switch (lang) {
      case SupportedLanguage.english:
        {
          _languageState.sink.add("en");
          return;
        }
      case SupportedLanguage.vietnamese:
        {
          _languageState.sink.add("vi");
          return;
        }
    }
  }

  void dispose() {
    _languageState.close();
  }
}
