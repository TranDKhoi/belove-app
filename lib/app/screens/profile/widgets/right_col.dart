import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/user.dart';
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
                        Icons.add_circle_outline,
                      ),
                    ),
                  ],
                );
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
                      Icons.add_circle_outline,
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
                  GlobalData.ins.currentUser!.partner!.name ?? "...",
                  style: const TextStyle(fontSize: 17),
                );
              }
              return const Text(
                "...",
                style: TextStyle(fontSize: 17),
              );
            }),
        StreamBuilder<Object>(
            stream: _bloc.partnerStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  dateFormat(
                    GlobalData.ins.currentUser!.partner!.birthday!,
                  ),
                  style: const TextStyle(fontSize: 17),
                );
              }
              return const Text(
                "...",
                style: TextStyle(fontSize: 17),
              );
            }),
      ],
    );
  }
}
