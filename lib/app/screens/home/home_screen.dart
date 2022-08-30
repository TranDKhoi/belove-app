import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:belove_app/app/screens/home/widgets/add_post_form.dart';
import 'package:belove_app/app/screens/home/widgets/header.dart';
import 'package:belove_app/app/screens/home/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../generated/l10n.dart';
import '../sidebar/sidebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _bloc = HomeBloc.ins;
  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _bloc.loadMorePost();
      }
    });
    super.initState();
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
        child: Column(
          children: [
            //HEADER
            const HomeHeader(),
            //TIMELINE
            if (GlobalData.ins.currentUser!.partner != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return const AddPostForm();
                            });
                        _bloc.getPost();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey[400]!),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.add_outline,
                                color: Colors.grey[400],
                              ),
                              Text(
                                S.of(context).morepost,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            const HomeTimeLine(),
          ],
        ),
      ),
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
