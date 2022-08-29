import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/screens/my_app/my_app_bloc.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../global_data/global_data.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({Key? key}) : super(key: key);

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).preference),
      ),
      body: Column(
        children: [
          StreamBuilder<bool>(
              stream: MyAppBloc.ins.darkModeStream,
              builder: (context, snapshot) {
                return Card(
                  child: SwitchListTile(
                    value: snapshot.hasData
                        ? snapshot.data!
                        : GlobalData.ins.isDark,
                    onChanged: (val) {
                      MyAppBloc.ins.changeDarkMode(val);
                    },
                    secondary: const Icon(
                      Icons.dark_mode_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(S.of(context).darkmode),
                    activeColor: AppColors.primaryColor,
                  ),
                );
              }),
          StreamBuilder<String>(
              stream: MyAppBloc.ins.languageStream,
              builder: (context, snapshot) {
                return Card(
                  child: SwitchListTile(
                    value: snapshot.hasData
                        ? snapshot.data! == "vi"
                            ? true
                            : false
                        : GlobalData.ins.currentLang == "vi"
                            ? true
                            : false,
                    onChanged: (val) {
                      if (val == true) {
                        MyAppBloc.ins
                            .changeLanguage(SupportedLanguage.vietnamese);
                      } else {
                        MyAppBloc.ins.changeLanguage(SupportedLanguage.english);
                      }
                    },
                    secondary: const Icon(
                      Icons.dark_mode_outlined,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(S.of(context).language),
                    activeColor: AppColors.primaryColor,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
