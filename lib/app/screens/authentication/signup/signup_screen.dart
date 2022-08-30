import 'package:belove_app/app/screens/authentication/signup/signup_bloc.dart';
import 'package:belove_app/app/screens/authentication/signup/signup_inherited.dart';
import 'package:belove_app/app/screens/authentication/signup/widgets/signup_wrapper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _bloc = SignUpBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpInherited(_bloc, child: const SignUpWrapper()),
    );
  }
}
