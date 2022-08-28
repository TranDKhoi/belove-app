import 'dart:async';
import 'dart:io';

import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/data/services/database.dart';
import 'package:belove_app/data/services/store.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../generated/l10n.dart';

class AddPostBloc {
  //STREAM-------------------------------------------
  final StreamController<List<String>> _imageStreamController =
      StreamController<List<String>>.broadcast();

  Stream<List<String>> get imageStream => _imageStreamController.stream;

  //DATA--------------------------------------------------
  List<String>? listImage = [];

//----------------------------------------------------
  pickMultiImage() async {
    listImage = await ImageHelper.ins.pickMultiImage();
    if (listImage != null) {
      _imageStreamController.sink.add(listImage!);
    }
  }

  pickSingleImage(index) async {
    var res = await ImageHelper.ins.pickSingleImage();
    if (res != null) {
      listImage![index] = res;
      _imageStreamController.sink.add(listImage!);
    }
  }

  removeImage(i) {
    listImage!.removeAt(i);
    _imageStreamController.sink.add(listImage!);
  }

  createNewPost(String title) async {
    if (title.isEmpty && (listImage == null || listImage!.isEmpty)) {
      EasyLoading.showToast(S.current.yourmustpostsomething);

      return;
    }

    DateTime createdAt = DateTime.now();
    if (listImage != null) {
      EasyLoading.show();

      var links = await StoreService.ins.uploadPostImages(
          listImage!.map((e) => File(e)).toList(), DateTime.now());
      if (links != null) {
        await DataBaseService.ins.createPost(title, links, createdAt);
      }
      EasyLoading.dismiss();
      navigatorKey.currentState?.pop();
      return;
    }
    EasyLoading.show();

    await DataBaseService.ins.createPost(title, null, createdAt);
    EasyLoading.dismiss();
    navigatorKey.currentState?.pop();
  }

  void dispose() {
    listImage = [];
    _imageStreamController.close();
  }
}
