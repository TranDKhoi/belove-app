import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:belove_app/app/screens/home/home_inherited.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';
import '../../../global_data/global_data.dart';
import '../../sidebar/sidebar_bloc.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = HomeInherited.of(context).bloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenSize.width,
      height: context.screenSize.height / 2.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset(
            "assets/images/timeline_wallpaper.jpg",
            fit: BoxFit.cover,
          ).image,
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StreamBuilder<int>(
                    stream: SideBarBloc.ins.beginDayStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                height: 1,
                              ),
                            ),
                            Text(
                              S.of(context).days,
                              style: const TextStyle(
                                color: Colors.white,
                                height: 0,
                              ),
                            ),
                          ],
                        );
                      }
                      if (GlobalData.ins.ourDay != null) {
                        return Row(
                          children: [
                            Text(
                              countDay(GlobalData.ins.ourDay!.beginDate!)
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                height: 1,
                              ),
                            ),
                            Text(
                              S.of(context).days,
                              style: const TextStyle(
                                color: Colors.white,
                                height: 0,
                              ),
                            ),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          const Text(
                            "0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              height: 1,
                            ),
                          ),
                          Text(
                            S.of(context).days,
                            style: const TextStyle(
                              color: Colors.white,
                              height: 0,
                            ),
                          ),
                        ],
                      );
                    }),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        GlobalData.ins.currentUser!.name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Ionicons.heart,
                          color: Colors.white,
                        ),
                      ),
                      GlobalData.ins.currentUser!.partner != null
                          ? Text(
                              GlobalData.ins.currentUser!.partner!.name!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              "...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
