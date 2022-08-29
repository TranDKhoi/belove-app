import 'package:belove_app/app/screens/setting/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';
import '../../../global_data/global_key.dart';

class LogOutForm extends StatelessWidget {
  const LogOutForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Wrap(
        children: [
          Column(
            children: [
              Text(S.of(context).areyousure),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      navigatorKey.currentState?.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cancel_outlined,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            S.of(context).no,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      SettingBloc.ins.logOut();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Ionicons.checkmark_circle_outline,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            S.of(context).yes,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
