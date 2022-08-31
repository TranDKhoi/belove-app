import 'dart:io';

import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StoreService {
  StoreService._();

  static final ins = StoreService._();

  final _store = FirebaseStorage.instance;

  uploadUserAvatar(File img) async {
    try {
      final ref =
          _store.ref().child("users/${GlobalData.ins.currentUser!.userId}");
      final uploadTask = ref.putFile(img);

      final snapShot = await uploadTask.whenComplete(() {});

      final url = await snapShot.ref.getDownloadURL();
      return url;
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  uploadPostImages(List<File> listImg, createdAt) async {
    try {
      List<String> downloadUrls = [];
      await Future.forEach(listImg, (File image) async {
        Reference ref = _store.ref().child(
            "post/${getCoupleId()}/$createdAt/${DateTime.now().toString()}");
        final UploadTask uploadTask = ref.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        final url = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(url);
      });

      return downloadUrls;
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  deletePostImage(String postId) async {
    await _store.ref("post/${getCoupleId()}/$postId/").listAll().then((result) {
      for (var file in result.items) {
        file.delete();
      }
    });
  }
}
