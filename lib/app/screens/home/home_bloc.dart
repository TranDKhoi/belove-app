import 'dart:async';

import 'package:belove_app/data/models/post.dart';
import 'package:belove_app/data/services/database.dart';

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
  loadMorePost() {
    _postStreamController.sink.add(posts);
  }

  getPost() async {
    var res = await DataBaseService.ins.getPosts();
    if (res != null) {
      return posts = res;
    }
  }
}
