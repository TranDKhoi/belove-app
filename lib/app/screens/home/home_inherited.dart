import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:flutter/material.dart';

class HomeInherited extends InheritedWidget {
  const HomeInherited(this.bloc, {Key? key, required Widget child})
      : super(key: key, child: child);

  final HomeBloc bloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static HomeInherited of(BuildContext context) {
    final HomeInherited? res =
        context.dependOnInheritedWidgetOfExactType<HomeInherited>();
    assert(res != null, "error");
    return res!;
  }
}
