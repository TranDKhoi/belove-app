import 'package:belove_app/app/screens/authentication/main_auth_screen.dart';
import 'package:belove_app/app/screens/authentication/signup/signup_screen.dart';
import 'package:belove_app/app/screens/wrapper/wrapper.dart';

final appRoute = {
  mainAuthScreen: (navigatorKey) => const MainAuthScreen(),
  wrapperScreen: (navigatorKey) => const Wrapper(),
  signUpScreen: (navigatorKey) => const SignUpScreen(),
};

//ROUTES NAME
const mainAuthScreen = "/";
const wrapperScreen = "wrapper";
const signUpScreen = "signUp";
