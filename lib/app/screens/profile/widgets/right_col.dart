import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/user.dart';
import '../../../core/utils/utils.dart';
import '../../../global_data/global_data.dart';
import 'connect_partner_form.dart';

class RightCol extends StatefulWidget {
  const RightCol({Key? key}) : super(key: key);

  @override
  State<RightCol> createState() => _RightColState();
}

class _RightColState extends State<RightCol> {
  final _bloc = ProfileBloc.ins;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<User>(
            stream: _bloc.partnerStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GlobalData.ins.currentUser!.partner!.avatar == ""
                        ? Image.asset(
                            GlobalData.ins.currentUser!.partner!.gender == 1
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
                                  GlobalData.ins.currentUser!.partner!.avatar!,
                                  fit: BoxFit.contain,
                                ).image,
                              ),
                            ],
                          ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ConnectPartnerForm();
                            });
                      },
                      child: const Icon(
                        Ionicons.add_circle_outline,
                      ),
                    ),
                  ],
                );
              }
              if (GlobalData.ins.currentUser!.partner != null) {
                if (GlobalData.ins.currentUser!.partner!.avatar != "") {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: Image.network(
                              GlobalData.ins.currentUser!.partner!.avatar!,
                              width: 110,
                              height: 110,
                            ).image,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const ConnectPartnerForm();
                              });
                        },
                        child: const Icon(
                          Ionicons.add_circle_outline,
                        ),
                      ),
                    ],
                  );
                }
              }
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.asset(
                    GlobalData.ins.currentUser!.gender == 0
                        ? "assets/images/girl.png"
                        : "assets/images/boy.png",
                    width: 110,
                    height: 110,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const ConnectPartnerForm();
                          });
                    },
                    child: const Icon(
                      Ionicons.add_circle_outline,
                    ),
                  ),
                ],
              );
            }),
        const SizedBox(height: 20),
        StreamBuilder<User>(
            stream: _bloc.partnerStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data!.name!,
                  style: const TextStyle(fontSize: 17),
                );
              }
              if (GlobalData.ins.currentUser!.partner != null) {
                return Text(
                  GlobalData.ins.currentUser!.partner!.name!,
                  style: const TextStyle(fontSize: 17),
                );
              }
              return const Text(
                "...",
                style: TextStyle(fontSize: 17),
              );
            }),
        GlobalData.ins.currentUser!.partner == null
            ? const Text(
                "...",
                style: TextStyle(fontSize: 17),
              )
            : StreamBuilder<Object>(
                stream: _bloc.partnerStream,
                initialData: GlobalData.ins.currentUser!.partner,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      dateFormat(
                        GlobalData.ins.currentUser!.partner!.birthday!,
                      ),
                      style: const TextStyle(fontSize: 17),
                    );
                  }
                  if (GlobalData.ins.currentUser!.partner!.birthday != null) {
                    return Text(
                      dateFormat(
                        GlobalData.ins.currentUser!.partner!.birthday!,
                      ),
                      style: const TextStyle(fontSize: 17),
                    );
                  }
                  return Text(
                    dateFormat(
                      GlobalData.ins.currentUser!.partner!.birthday!,
                    ),
                    style: const TextStyle(fontSize: 17),
                  );
                }),
      ],
    );
  }
}
