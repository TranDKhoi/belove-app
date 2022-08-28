import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:belove_app/app/screens/home/widgets/sidebar.dart';
import 'package:belove_app/app/screens/home/widgets/sidebar_bloc.dart';
import 'package:belove_app/app/screens/profile/profile_bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/post.dart';
import '../../../data/models/user.dart';
import '../../../generated/l10n.dart';
import '../../global_data/global_data.dart';

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
            child: const Icon(Icons.menu),
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
        controller: _sc,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //HEADER
            Container(
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
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
                                      countDay(
                                              GlobalData.ins.ourDay!.beginDate!)
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
                          height: 50,
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
                                  Icons.favorite,
                                  color: Colors.white,
                                ),
                              ),
                              StreamBuilder<User>(
                                  stream: ProfileBloc.ins.partnerStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!.name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                    if (GlobalData.ins.currentUser!.partner !=
                                        null) {
                                      return Text(
                                        GlobalData
                                            .ins.currentUser!.partner!.name!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                    return const Text(
                                      "...",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //TIMELINE
            FutureBuilder(
              future: _bloc.getPost(),
              builder: (context, asyncSnap) {
                if (asyncSnap.hasData) {
                  return StreamBuilder<List<Post>>(
                    stream: _bloc.postStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data!
                              .map(
                                (i) => Card(
                                  child: Text(i.id!),
                                ),
                              )
                              .toList(),
                        );
                      }
                      return Column(
                        children: _bloc.posts
                            .map(
                              (i) => Card(
                                child: Text(i.id!),
                              ),
                            )
                            .toList(),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text("..."),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
