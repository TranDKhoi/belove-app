import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:flutter/material.dart';

class ProfileInherited extends InheritedWidget {
  const ProfileInherited(this.bloc, {Key? key, required Widget child})
      : super(key: key, child: child);

  final ProfileBloc bloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static ProfileInherited of(BuildContext context) {
    final ProfileInherited? res =
        context.dependOnInheritedWidgetOfExactType<ProfileInherited>();
    assert(res != null, "error");
    return res!;
  }
}
