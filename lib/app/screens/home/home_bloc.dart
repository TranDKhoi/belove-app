import 'dart:async';

import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/post.dart';
import 'package:belove_app/data/services/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeBloc {
  HomeBloc._();

  static final ins = HomeBloc._();

  //STREAM------------------------------------------
  final StreamController<List<Post>> _postStreamController =
      StreamController<List<Post>>.broadcast();

  Stream<List<Post>> get postStream => _postStreamController.stream;

  //DATA----------------------------------------------
  List<Post> posts = [];

  //EVENT------------------------------------------------
  loadMorePost() async {
    if (GlobalData.ins.currentUser!.partner == null) return;
    List<Post>? res = await DataBaseService.ins.getMorePosts();
    if (res != null) {
      for (int i = 0; i < res.length; i++) {
        res[i].poster = await DataBaseService.ins.getUserById(res[i].posterId!);
      }
      posts.addAll(res);
      _postStreamController.sink.add(posts);
    }
  }

  getPost() async {
    if (GlobalData.ins.currentUser!.partner == null) return;
    EasyLoading.show();
    List<Post>? res = await DataBaseService.ins.getPosts();
    if (res != null) {
      for (int i = 0; i < res.length; i++) {
        res[i].poster = await DataBaseService.ins.getUserById(res[i].posterId!);
      }
      EasyLoading.dismiss();
      posts = res;
      _postStreamController.sink.add(posts);
    }
    EasyLoading.dismiss();
  }

  void dispose() {
    _postStreamController.close();
  }
}
