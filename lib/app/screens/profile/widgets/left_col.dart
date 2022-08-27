import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../global_data/global_data.dart';

class LeftCol extends StatefulWidget {
  const LeftCol({Key? key}) : super(key: key);

  @override
  State<LeftCol> createState() => _LeftColState();
}

class _LeftColState extends State<LeftCol> {
  final _bloc = ProfileBloc.ins;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GlobalData.ins.currentUser!.avatar == null
                ? Image.asset(
                    GlobalData.ins.currentUser!.gender == 0
                        ? "assets/images/boy.png"
                        : "assets/images/girl.png",
                    width: 110,
                    height: 110,
                  )
                : StreamBuilder<String>(
                    stream: _bloc.avatarStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: Image.network(
                                snapshot.data!,
                                fit: BoxFit.contain,
                              ).image,
                            ),
                          ],
                        );
                      } else {
                        if (GlobalData.ins.currentUser!.avatar != "") {
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: Image.asset(
                                  GlobalData.ins.currentUser!.avatar!,
                                  fit: BoxFit.contain,
                                ).image,
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: Image.asset(
                                "assets/images/boy.png",
                                fit: BoxFit.contain,
                              ).image,
                            ),
                          ],
                        );
                      }
                    }),
            GestureDetector(
              onTap: () {
                _bloc.changeAvatar();
              },
              child: const Icon(
                Icons.camera_alt_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          GlobalData.ins.currentUser!.name!,
          style: const TextStyle(fontSize: 17),
        ),
        GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                  height: context.screenSize.height / 3,
                  color: CupertinoColors.systemBackground.resolveFrom(context),
                  child: SafeArea(
                    top: false,
                    child: CupertinoDatePicker(
                      initialDateTime: GlobalData.ins.currentUser!.birthday,
                      maximumDate: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime newDate) {
                        _bloc.uploadBirthDay(newDate);
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: StreamBuilder<String>(
            stream: _bloc.birthDayStream,
            initialData: dateFormat(GlobalData.ins.currentUser!.birthday!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                );
              }
              return Text(
                S.of(context).dateofbirth,
                style: const TextStyle(
                  fontSize: 18,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
