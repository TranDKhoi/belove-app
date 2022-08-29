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

  /// `Your name`
  String get yourname {
    return Intl.message(
      'Your name',
      name: 'yourname',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseenteryourname {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseenteryourname',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dateofbirth {
    return Intl.message(
      'Date of birth',
      name: 'dateofbirth',
      desc: '',
      args: [],
    );
  }

  /// `You are`
  String get youare {
    return Intl.message(
      'You are',
      name: 'youare',
      desc: '',
      args: [],
    );
  }

  /// `Enter your birthday`
  String get enteryourbirthday {
    return Intl.message(
      'Enter your birthday',
      name: 'enteryourbirthday',
      desc: '',
      args: [],
    );
  }

  /// `Your profile`
  String get yourprofile {
    return Intl.message(
      'Your profile',
      name: 'yourprofile',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Partner Id`
  String get partnerId {
    return Intl.message(
      'Partner Id',
      name: 'partnerId',
      desc: '',
      args: [],
    );
  }

  /// `My Id`
  String get myId {
    return Intl.message(
      'My Id',
      name: 'myId',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get copied {
    return Intl.message(
      'Copied',
      name: 'copied',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get usernotfound {
    return Intl.message(
      'User not found',
      name: 'usernotfound',
      desc: '',
      args: [],
    );
  }

  /// `Is this your beloved?`
  String get isthisyourbeloved {
    return Intl.message(
      'Is this your beloved?',
      name: 'isthisyourbeloved',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Find someone who is single!`
  String get findsomeonewhoissingle {
    return Intl.message(
      'Find someone who is single!',
      name: 'findsomeonewhoissingle',
      desc: '',
      args: [],
    );
  }

  /// `Timeline`
  String get timeline {
    return Intl.message(
      'Timeline',
      name: 'timeline',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Since`
  String get since {
    return Intl.message(
      'Since',
      name: 'since',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `years anniversary`
  String get yearanniversary {
    return Intl.message(
      'years anniversary',
      name: 'yearanniversary',
      desc: '',
      args: [],
    );
  }

  /// `Check your email to verify account`
  String get verifyyouremail {
    return Intl.message(
      'Check your email to verify account',
      name: 'verifyyouremail',
      desc: '',
      args: [],
    );
  }

  /// `After verified, you can go back and log in with this account`
  String get Afterverified {
    return Intl.message(
      'After verified, you can go back and log in with this account',
      name: 'Afterverified',
      desc: '',
      args: [],
    );
  }

  /// `More post`
  String get morepost {
    return Intl.message(
      'More post',
      name: 'morepost',
      desc: '',
      args: [],
    );
  }

  /// `What memories do you want to save?`
  String get whatmemoriesdoyouwanttosave {
    return Intl.message(
      'What memories do you want to save?',
      name: 'whatmemoriesdoyouwanttosave',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `You must post something`
  String get yourmustpostsomething {
    return Intl.message(
      'You must post something',
      name: 'yourmustpostsomething',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areyousure {
    return Intl.message(
      'Are you sure?',
      name: 'areyousure',
      desc: '',
      args: [],
    );
  }

  /// `Preference`
  String get preference {
    return Intl.message(
      'Preference',
      name: 'preference',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkmode {
    return Intl.message(
      'Dark mode',
      name: 'darkmode',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get language {
    return Intl.message(
      'Vietnamese',
      name: 'language',
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
