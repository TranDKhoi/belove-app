// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up`
  String get signup {
    return Intl.message(
      'Sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get loginwithfb {
    return Intl.message(
      'Login with Facebook',
      name: 'loginwithfb',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enteryouremail {
    return Intl.message(
      'Enter your email',
      name: 'enteryouremail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enteryourpass {
    return Intl.message(
      'Enter your password',
      name: 'enteryourpass',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email or password`
  String get pleaseenteryouremailorpassword {
    return Intl.message(
      'Please enter your email or password',
      name: 'pleaseenteryouremailorpassword',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email`
  String get pleaseenteremail {
    return Intl.message(
      'Please enter the email',
      name: 'pleaseenteremail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password`
  String get pleaseenterthepassword {
    return Intl.message(
      'Please enter the password',
      name: 'pleaseenterthepassword',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrectpassword {
    return Intl.message(
      'Incorrect password',
      name: 'incorrectpassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must at least 6 characters`
  String get mustbe6 {
    return Intl.message(
      'Password must at least 6 characters',
      name: 'mustbe6',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
