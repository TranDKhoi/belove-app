import 'package:belove_app/app/global_data/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../core/utils/utils.dart';
import '../../core/values/color.dart';
import '../authentication/bio/bio_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool canReturn;
  final _bloc = BioBloc.ins;

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
              onTap: () {},
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
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GlobalData.ins.currentUser!.avatar == null
                          ? Image.asset(
                              GlobalData.ins.currentUser!.gender == 0
                                  ? "assets/images/boy.png"
                                  : "assets/images/girl.png",
                              width: 80,
                              height: 80,
                            )
                          : Image.network(
                              GlobalData.ins.currentUser!.avatar!,
                              width: 80,
                              height: 80,
                            ),
                      GestureDetector(
                        onTap: () {
                          //change avatar
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
                            color: CupertinoColors.systemBackground
                                .resolveFrom(context),
                            child: SafeArea(
                              top: false,
                              child: CupertinoDatePicker(
                                initialDateTime:
                                    GlobalData.ins.currentUser!.birthday,
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
                      initialData:
                          dateFormat(GlobalData.ins.currentUser!.birthday!),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30)
                    .copyWith(bottom: 50),
                child: const Icon(
                  Icons.favorite,
                  color: AppColors.primaryColor,
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    GlobalData.ins.currentUser!.gender == 0
                        ? "assets/images/girl.png"
                        : "assets/images/boy.png",
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    GlobalData.ins.currentUser!.partner != null
                        ? GlobalData.ins.currentUser!.partner!.name!
                        : "...",
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(
                    GlobalData.ins.currentUser!.partner != null
                        ? dateFormat(
                            GlobalData.ins.currentUser!.partner!.birthday!,
                          )
                        : "...",
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
