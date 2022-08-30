import 'package:belove_app/app/screens/authentication/signup/signup_bloc.dart';
import 'package:flutter/material.dart';

class SignUpInherited extends InheritedWidget {
  SignUpInherited(
    this.bloc, {
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final SignUpBloc bloc;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static SignUpInherited of(BuildContext context) {
    final SignUpInherited? res =
        context.dependOnInheritedWidgetOfExactType<SignUpInherited>();
    assert(res != null, 'Not found in context');
    return res!;
  }
}
