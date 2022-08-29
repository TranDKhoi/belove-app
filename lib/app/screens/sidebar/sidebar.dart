import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/screens/sidebar/sidebar_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../generated/l10n.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late int myBirthDay;
  int? yourBirthDay;
  final _bloc = SideBarBloc.ins;

  @override
  void initState() {
    myBirthDay = howManyDayLeft(GlobalData.ins.currentUser!.birthday!);
    if (GlobalData.ins.currentUser!.partner != null) {
      yourBirthDay =
          howManyDayLeft(GlobalData.ins.currentUser!.partner!.birthday!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Text(
                      S.of(context).since,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    StreamBuilder<int>(
                        stream: _bloc.beginDayStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              dateFormat(GlobalData.ins.ourDay!.beginDate!),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            );
                          }
                          if (GlobalData.ins.ourDay != null) {
                            return Text(
                              dateFormat(GlobalData.ins.ourDay!.beginDate!),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            );
                          }
                          return const Text(
                            "...",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        if (GlobalData.ins.currentUser!.partnerId == "") return;
                        await showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: context.screenSize.height / 3,
                              color: CupertinoColors.systemBackground
                                  .resolveFrom(context),
                              child: SafeArea(
                                top: false,
                                child: CupertinoDatePicker(
                                  initialDateTime: GlobalData.ins.ourDay != null
                                      ? GlobalData.ins.ourDay!.beginDate!
                                      : DateTime.now(),
                                  maximumDate: DateTime.now(),
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (DateTime newDate) {
                                    _bloc.pickedDate = newDate;
                                  },
                                ),
                              ),
                            );
                          },
                        );
                        _bloc.uploadBeginDay();
                      },
                      child: StreamBuilder<int>(
                          stream: _bloc.beginDayStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data.toString(),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      S.of(context).days,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (GlobalData.ins.ourDay != null) {
                              return CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      countDay(
                                              GlobalData.ins.ourDay!.beginDate!)
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    Text(
                                      S.of(context).days,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 70,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    S.of(context).days,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              isThreeLine: true,
              leading: const Icon(
                Icons.cake_outlined,
                color: AppColors.primaryColor,
                size: 30,
              ),
              title: Text(
                GlobalData.ins.currentUser!.name!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                dateFormat(GlobalData.ins.currentUser!.birthday!),
              ),
              trailing: Text(
                "D-$myBirthDay",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            if (GlobalData.ins.currentUser!.partner != null)
              ListTile(
                isThreeLine: true,
                leading: const Icon(
                  Icons.cake_outlined,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
                title: Text(
                  GlobalData.ins.currentUser!.partner!.name!,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  dateFormat(GlobalData.ins.currentUser!.partner!.birthday!),
                ),
                trailing: Text(
                  "D-$yourBirthDay",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const Divider(),
            if (GlobalData.ins.ourDay != null)
              StreamBuilder<int>(
                  stream: _bloc.beginDayStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        isThreeLine: true,
                        leading: const Icon(
                          Ionicons.gift_outline,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                        title: Text(
                          "${countYear(GlobalData.ins.ourDay!.beginDate!)} ${S.of(context).yearanniversary}",
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          dateFormat(GlobalData.ins.ourDay!.beginDate!),
                        ),
                        trailing: Text(
                          "D-${howManyDayLeft(GlobalData.ins.ourDay!.beginDate!)}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return ListTile(
                      isThreeLine: true,
                      leading: const Icon(
                        Ionicons.gift_outline,
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                      title: Text(
                        "${countYear(GlobalData.ins.ourDay!.beginDate!)} ${S.of(context).yearanniversary}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        dateFormat(GlobalData.ins.currentUser!.birthday!),
                      ),
                      trailing: Text(
                        "D-${howManyDayLeft(GlobalData.ins.ourDay!.beginDate!)}",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
