import 'package:belove_app/app/screens/authentication/bio/bio_bloc.dart';
import 'package:flutter/material.dart';

class BioInherited extends InheritedWidget {
  BioInherited(
    this.bloc, {
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final BioBloc bloc;
  final formKey = GlobalKey<FormState>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static BioInherited of(BuildContext context) {
    final BioInherited? result =
        context.dependOnInheritedWidgetOfExactType<BioInherited>();
    assert(result != null, 'Not found in context');
    return result!;
  }
}
