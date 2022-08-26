// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "OK": MessageLookupByLibrary.simpleMessage("OK"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "dateofbirth": MessageLookupByLibrary.simpleMessage("Date of birth"),
        "enteryourbirthday":
            MessageLookupByLibrary.simpleMessage("Enter your birthday"),
        "enteryouremail":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "enteryourpass":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "incorrectpassword":
            MessageLookupByLibrary.simpleMessage("Incorrect password"),
        "login": MessageLookupByLibrary.simpleMessage("Log in"),
        "loginwithfb":
            MessageLookupByLibrary.simpleMessage("Login with Facebook"),
        "mustbe6": MessageLookupByLibrary.simpleMessage(
            "Password must at least 6 characters"),
        "pleaseenteremail":
            MessageLookupByLibrary.simpleMessage("Please enter the email"),
        "pleaseenterthepassword":
            MessageLookupByLibrary.simpleMessage("Please enter the password"),
        "pleaseenteryouremailorpassword": MessageLookupByLibrary.simpleMessage(
            "Please enter your email or password"),
        "pleaseenteryourname":
            MessageLookupByLibrary.simpleMessage("Please enter your name"),
        "signup": MessageLookupByLibrary.simpleMessage("Sign up"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "youare": MessageLookupByLibrary.simpleMessage("You are"),
        "yourname": MessageLookupByLibrary.simpleMessage("Your name"),
        "yourprofile": MessageLookupByLibrary.simpleMessage("Your profile")
      };
}
