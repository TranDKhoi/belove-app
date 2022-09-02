import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/screens/sidebar/sidebar_bloc.dart';
import 'package:belove_app/data/models/anniversary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../generated/l10n.dart';
import '../core/values/color.dart';
import '../global_data/global_key.dart';

class AnniversaryItem extends StatelessWidget {
  const AnniversaryItem({Key? key, required this.item}) : super(key: key);

  final Anniversary item;

  @override
  Widget build(BuildContext context) {
    final dayLeft = howManyDayLeft(item.date!);
    if (item.title == " years anniversary") {
      item.title = "${countYear(item.date!)} ${S.of(context).yearanniversary}";
    }

    return InkWell(
      onLongPress: () async {
        if (item.title == GlobalData.ins.currentUser!.name ||
            item.title == GlobalData.ins.currentUser!.partner!.name ||
            item.title == " years anniversary") {
          return;
        }
        await showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () {
                        SideBarBloc.ins.deleteAnniversary(item.id);
                        navigatorKey.currentState?.pop();
                      },
                      isDestructiveAction: true,
                      child: Text(S.of(context).delete)),
                ],
              );
            });
      },
      child: ListTile(
        isThreeLine: true,
        leading: Icon(
          !isBirthDay() ? Ionicons.gift_outline : Icons.cake_outlined,
          color: AppColors.primaryColor,
          size: 30,
        ),
        title: Text(
          item.title!,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        subtitle: Text(
          dateFormat(item.date!),
        ),
        trailing: Text(
          "D-$dayLeft",
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  isBirthDay() {
    if ((item.date! == GlobalData.ins.currentUser!.birthday &&
            item.title == GlobalData.ins.currentUser!.name) ||
        (item.date! == GlobalData.ins.currentUser!.partner!.birthday &&
            item.title == GlobalData.ins.currentUser!.partner!.name)) {
      return true;
    }
    return false;
  }
}
