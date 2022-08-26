import 'package:belove_app/app/screens/authentication/bio/bio_screen.dart';
import 'package:belove_app/app/screens/authentication/main_auth_screen.dart';
import 'package:belove_app/app/screens/authentication/signup/signup_screen.dart';
import 'package:belove_app/app/screens/profile/profile_screen.dart';
import 'package:belove_app/app/screens/wrapper/wrapper.dart';

final appRoute = {
  mainAuthScreen: (navigatorKey) => const MainAuthScreen(),
  wrapperScreen: (navigatorKey) => const Wrapper(),
  signUpScreen: (navigatorKey) => const SignUpScreen(),
  bioScreen: (navigatorKey) => const BioScreen(),
  profileScreen: (navigatorKey) => const ProfileScreen(),
};

//ROUTES NAME
const mainAuthScreen = "/";
const wrapperScreen = "wrapper";
const signUpScreen = "signUp";
const bioScreen = "bio_screen";
const profileScreen = "profile_screen";
