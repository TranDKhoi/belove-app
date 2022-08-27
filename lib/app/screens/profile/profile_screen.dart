import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:belove_app/app/screens/profile/widgets/left_col.dart';
import 'package:belove_app/app/screens/profile/widgets/right_col.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../core/values/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool canReturn;
  final _bloc = ProfileBloc.ins;

  @override
  void didChangeDependencies() {
    canReturn = ModalRoute.of(context)?.settings.arguments as bool;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
                    ?.pushNamedAndRemoveUntil(wrapperScreen, (_) => false);
              },
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LeftCol(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30)
                    .copyWith(bottom: 50),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.primaryColor,
                ),
              ),
              const RightCol(),
            ],
          ),
        ],
      ),
    );
  }
}
