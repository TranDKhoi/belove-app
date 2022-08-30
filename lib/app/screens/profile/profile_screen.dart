import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:belove_app/app/screens/profile/profile_inherited.dart';
import 'package:belove_app/app/screens/profile/widgets/profile_wrapper.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool canReturn = true;
  final _bloc = ProfileBloc();

  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      canReturn = ModalRoute.of(context)?.settings.arguments as bool;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          S.of(context).yourprofile,
          textAlign: TextAlign.center,
        ),
        actions: [
          Visibility(
            visible: canReturn ? false : true,
            child: GestureDetector(
              child: Center(
                child: Text(S.of(context).skip),
              ),
              onTap: () {
                navigatorKey.currentState
                    ?.pushNamedAndRemoveUntil(bottomBarScreen, (_) => false);
              },
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: ProfileInherited(_bloc, child: const ProfileWrapper()),
    );
  }
}
