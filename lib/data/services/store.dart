import 'dart:io';

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
}
