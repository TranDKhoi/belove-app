import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/user.dart';
import '../../../core/utils/utils.dart';
import '../../../global_data/global_data.dart';
import '../profile_inherited.dart';
import 'connect_partner_form.dart';

class RightCol extends StatefulWidget {
  const RightCol({Key? key}) : super(key: key);

  @override
  State<RightCol> createState() => _RightColState();
}

class _RightColState extends State<RightCol> {
  late ProfileBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = ProfileInherited.of(context).bloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GlobalData.ins.currentUser!.partnerId == ""
                ? Image.asset(
                    "assets/images/${GlobalData.ins.currentUser!.gender == 0 ? "girl" : "boy"}.png",
                    width: 110,
                    height: 110,
                  )
                : StreamBuilder<User>(
                    stream: _bloc.partnerStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        snapshot.data!.avatar == ""
                            ? Image.asset(
                                snapshot.data!.gender == 1
                                    ? "assets/images/girl.png"
                                    : "assets/images/boy.png",
                                width: 110,
                                height: 110,
                              )
                            : Row(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: Image.network(
                                      snapshot.data!.avatar!,
                                      fit: BoxFit.contain,
                                    ).image,
                                  ),
                                ],
                              );
                      }
                      return GlobalData.ins.currentUser!.partner!.avatar == ""
                          ? Image.asset(
                              "assets/images/${GlobalData.ins.currentUser!.partner!.gender == 1 ? "girl" : "boy"}.png",
                              width: 110,
                              height: 110,
                            )
                          : Row(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: Image.network(
                                    GlobalData
                                        .ins.currentUser!.partner!.avatar!,
                                    fit: BoxFit.contain,
                                  ).image,
                                ),
                              ],
                            );
                    }),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ConnectPartnerForm(_bloc);
                    });
              },
              child: const Icon(
                Ionicons.add_circle_outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GlobalData.ins.currentUser!.partner == null
            ? Column(
                children: const [
                  Text(
                    "...",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "...",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              )
            : StreamBuilder<User>(
                stream: _bloc.partnerStream,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Text(
                        snapshot.hasData
                            ? snapshot.data!.name!
                            : GlobalData.ins.currentUser!.partner!.name!,
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(
                        dateFormat(
                          snapshot.hasData
                              ? snapshot.data!.birthday!
                              : GlobalData.ins.currentUser!.partner!.birthday!,
                        ),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  );
                },
              ),
      ],
    );
  }
}
