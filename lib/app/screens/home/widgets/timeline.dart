import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:belove_app/app/screens/home/home_inherited.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/post.dart';
import '../../../commons/post_item.dart';
import '../../../global_data/global_data.dart';

class HomeTimeLine extends StatefulWidget {
  const HomeTimeLine({Key? key}) : super(key: key);

  @override
  State<HomeTimeLine> createState() => _HomeTimeLineState();
}

class _HomeTimeLineState extends State<HomeTimeLine> {
  late HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = HomeInherited.of(context).bloc;
    _bloc.getPost();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
        stream: _bloc.postStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: _bloc.posts.map((e) => PostItem(item: e)).toList(),
            );
          }
          return GlobalData.ins.isDark
              ? Image.asset("assets/images/empty_dark.png")
              : Image.asset("assets/images/empty.png");
        });
  }
}
