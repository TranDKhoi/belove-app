import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:belove_app/app/screens/home/home_inherited.dart';
import 'package:belove_app/app/screens/home/widgets/home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../sidebar/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc();
  final ScrollController _sc = ScrollController();

  @override
  initState() {
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _bloc.loadMorePost();
      }
    });
    _bloc.getPost();
    super.initState();
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
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(Ionicons.menu_outline),
          );
        }),
        title: const Text(
          "BeLove",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const SideBar(),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _sc,
          child: HomeInherited(_bloc, child: const HomeWrapper())),
      floatingActionButton: GlobalData.ins.currentUser!.partner != null
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              onPressed: () {
                navigatorKey.currentState?.pushNamed(chatScreen);
              },
              child: const Icon(Ionicons.chatbubble_outline),
            )
          : null,
    );
  }
}
