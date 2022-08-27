import 'package:belove_app/app/screens/home/home_screen.dart';
import 'package:belove_app/app/screens/home/widgets/sidebar_bloc.dart';
import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:belove_app/app/screens/profile/profile_screen.dart';
import 'package:belove_app/app/screens/wrapper/wrapper_bloc.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final _bloc = WrapperBloc.ins;

  List<Widget> pages = [
    const HomeScreen(),
    Text("2"),
    const ProfileScreen(),
  ];

  @override
  void dispose() {
    ProfileBloc.ins.dispose();
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
                    icon: const Icon(Icons.home_outlined),
                    label: S.of(context).timeline,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: S.of(context).calendar,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.grid_view_outlined),
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
