import 'package:belove_app/app/screens/home/home_screen.dart';
import 'package:belove_app/app/screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../generated/l10n.dart';
import '../sidebar/sidebar_bloc.dart';
import 'bottom_bar_bloc.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _bloc = BottomBarBloc.ins;

  List<Widget> pages = [
    const HomeScreen(),
    Text("2"),
    const SettingScreen(),
  ];

  @override
  void dispose() {
    SideBarBloc.ins.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: _bloc.currentPageStream,
        initialData: 0,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return pages[snapShot.data!];
          }
          return pages[0];
        },
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: _bloc.currentPageStream,
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BottomNavigationBar(
                onTap: (i) {
                  _bloc.changeCurrentPage(i);
                },
                currentIndex: snapshot.data!,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 5,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Ionicons.home_outline),
                    label: S.of(context).timeline,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Ionicons.calendar_outline),
                    label: S.of(context).calendar,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Ionicons.grid_outline),
                    label: S.of(context).more,
                  ),
                ],
              );
            }
            return const SizedBox();
          }),
    );
  }
}
