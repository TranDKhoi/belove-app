import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:flutter/material.dart';

class HomeTimeLine extends StatefulWidget {
  const HomeTimeLine({Key? key}) : super(key: key);

  @override
  State<HomeTimeLine> createState() => _HomeTimeLineState();
}

class _HomeTimeLineState extends State<HomeTimeLine> {
  final _bloc = HomeBloc.ins;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _bloc.getPost(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: _bloc.posts
                .map(
                  (e) => Card(
                    child:
                        Text(e.images == [] ? "11" : e.images![0].toString()),
                  ),
                )
                .toList(),
          );
        }
        return Column(
          children: _bloc.posts
              .map(
                (e) => Card(
                  child: Text(e.id!),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
