import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/screens/sidebar/sidebar_bloc.dart';
import 'package:belove_app/app/screens/sidebar/widgets/add_anniversary_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/anniversary.dart';
import '../../../generated/l10n.dart';
import '../../commons/anniversary_item.dart';
import '../../core/values/color.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final _bloc = SideBarBloc.ins;

  @override
  void initState() {
    _bloc.getAnniversary();
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).since,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GlobalData.ins.ourDay == null
                            ? const Text(
                                "...",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : StreamBuilder<List<Anniversary>>(
                                stream: _bloc.anniverStream,
                                builder: (context, snapshot) {
                                  return Text(
                                    dateFormat(snapshot.hasData
                                        ? GlobalData.ins.ourDay!.date!
                                        : GlobalData.ins.ourDay!.date!),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                }),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            if (GlobalData.ins.currentUser!.partnerId == "") {
                              return;
                            }
                            await showDatePicker();
                            if (GlobalData.ins.ourDay == null) {
                              _bloc.createBeginDay();
                            } else {
                              _bloc.updateBeginDay();
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StreamBuilder<List<Anniversary>>(
                                    stream: _bloc.anniverStream,
                                    builder: (context, snapshot) {
                                      return Text(
                                        countDay(snapshot.hasData
                                                ? GlobalData.ins.ourDay != null
                                                    ? GlobalData
                                                        .ins.ourDay!.date!
                                                    : DateTime.now().add(
                                                        const Duration(days: 2))
                                                : DateTime.now().add(
                                                    const Duration(days: 2)))
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: AppColors.primaryColor,
                                        ),
                                      );
                                    }),
                                Text(
                                  S.of(context).days,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        right: 10,
                        child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AddAnniversaryForm();
                                  });
                            },
                            child: const Icon(Ionicons.create_outline)))
                  ],
                ),
              ),
            ),
            StreamBuilder<List<Anniversary>>(
              builder: (context, snap) {
                if (snap.hasData) {
                  return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (c, i) =>
                            AnniversaryItem(item: snap.data![i]),
                        separatorBuilder: (c1, index) => const Divider(
                              height: 0,
                            ),
                        itemCount: _bloc.anniList!.length),
                  );
                }
                return const SizedBox();
              },
              stream: _bloc.anniverStream,
            ),
          ],
        ),
      ),
    );
  }

  showDatePicker() async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SizedBox(
          height: context.screenSize.height / 3,
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              backgroundColor: Colors.grey,
              initialDateTime: GlobalData.ins.ourDay != null
                  ? GlobalData.ins.ourDay!.date!
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
  }
}
