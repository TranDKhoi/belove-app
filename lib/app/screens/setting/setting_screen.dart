import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/app/screens/setting/widgets/logout_form.dart';
import 'package:belove_app/app/screens/setting/widgets/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../generated/l10n.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BeLove",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Wrap(
        children: [
          SettingItem(
            onTap: () {
              navigatorKey.currentState?.pushNamed(profileScreen);
            },
            icon: Ionicons.happy_outline,
            title: S.of(context).profile,
          ),
          SettingItem(
            onTap: () {
              navigatorKey.currentState?.pushNamed(preferenceScreen);
            },
            icon: Ionicons.settings_outline,
            title: S.of(context).setting,
          ),
          SettingItem(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return const LogOutForm();
                  });
            },
            icon: Ionicons.exit_outline,
            title: S.of(context).logout,
          ),
        ],
      ),
    );
  }
}
