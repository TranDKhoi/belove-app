import 'dart:async';

import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/post.dart';
import 'package:belove_app/data/services/database/timeline_base.dart';
import 'package:belove_app/data/services/database/user_base.dart';
import 'package:belove_app/data/services/store.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeBloc {
  //STREAM------------------------------------------
  final StreamController<List<Post>> _postStreamController =
      StreamController<List<Post>>.broadcast();

  Stream<List<Post>> get postStream => _postStreamController.stream;

  //DATA----------------------------------------------
  List<Post> posts = [];

  //EVENT------------------------------------------------
  loadMorePost() async {
    if (GlobalData.ins.currentUser!.partner == null) return;
    List<Post>? res = await TimelineBaseService.ins.getMorePosts();
    if (res != null) {
      for (int i = 0; i < res.length; i++) {
        res[i].poster = await UserBaseService.ins.getUserById(res[i].posterId!);
      }
      posts.addAll(res);
      _postStreamController.sink.add(posts);
    }
  }

  getPost() async {
    if (GlobalData.ins.currentUser!.partner == null) return;
    EasyLoading.show();
    List<Post>? res = await TimelineBaseService.ins.getPosts();
    if (res != null) {
      for (int i = 0; i < res.length; i++) {
        res[i].poster = await UserBaseService.ins.getUserById(res[i].posterId!);
      }
      EasyLoading.dismiss();
      posts = res;
      _postStreamController.sink.add(posts);
    } else {
      posts = [];
      _postStreamController.sink.add(posts);
    }
    EasyLoading.dismiss();
  }

  deletePost(Post post) async {
    await TimelineBaseService.ins.deletePost(post.id!);
    if (post.images != null) {
      await StoreService.ins.deletePostImage(post.id!);
    }
    getPost();
  }

  void dispose() {
    _postStreamController.close();
  }
}
