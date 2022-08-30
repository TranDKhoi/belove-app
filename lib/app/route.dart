import 'package:belove_app/app/screens/authentication/bio/bio_screen.dart';
import 'package:belove_app/app/screens/authentication/main_auth_screen.dart';
import 'package:belove_app/app/screens/authentication/signup/signup_screen.dart';
import 'package:belove_app/app/screens/bottom_bar/bottom_bar.dart';
import 'package:belove_app/app/screens/chat/chat_screen.dart';
import 'package:belove_app/app/screens/profile/profile_screen.dart';
import 'package:belove_app/app/screens/setting/preference_screen.dart';

final appRoute = {
  mainAuthScreen: (navigatorKey) => const MainAuthScreen(),
  bottomBarScreen: (navigatorKey) => const BottomBar(),
  signUpScreen: (navigatorKey) => const SignUpScreen(),
  bioScreen: (navigatorKey) => const BioScreen(),
  profileScreen: (navigatorKey) => const ProfileScreen(),
  preferenceScreen: (navigatorKey) => const PreferenceScreen(),
  chatScreen: (navigatorKey) => const ChatScreen(),
};

//ROUTES NAME
const mainAuthScreen = "/";
const bottomBarScreen = "bottom_bar";
const signUpScreen = "signUp";
const bioScreen = "bio_screen";
const profileScreen = "profile_screen";
const preferenceScreen = "preference_screen";
const chatScreen = "chat_screen";
