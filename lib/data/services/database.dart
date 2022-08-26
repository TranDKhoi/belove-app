import 'package:belove_app/app/global_data/global_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/user.dart';

class DataBaseService {
  DataBaseService._();

  static final ins = DataBaseService._();

  final _store = FirebaseFirestore.instance;

  dynamic getUserById(String id) async {
    var query = await _store.collection("users").doc(id).get().catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.data();
    if (data != null) {
      return User(
        userId: data["userId"],
        email: data["email"],
      );
    }
    return null;
  }

  uploadUserInfo(User user) async {
    await _store.collection("users").doc(user.userId).set({
      "userId": user.userId,
      "email": user.email,
      "partnerId": user.partner?.userId ?? "",
      "gender": user.gender ?? -1,
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  createChatRoom() async {
    String roomId = "empty";

    if (GlobalData.ins.currentUser!.gender == 0) {
      roomId = GlobalData.ins.currentUser!.userId! +
          GlobalData.ins.currentUser!.partner!.userId!;
    } else if (GlobalData.ins.currentUser!.gender == 1) {
      roomId = GlobalData.ins.currentUser!.partner!.userId! +
          GlobalData.ins.currentUser!.userId!;
    }

    //check if room is existed
    var query =
        await _store.collection("room").doc(roomId).get().catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.data();
    if (data == null) {
      await _store.collection("room").doc(roomId).set({
        "roomId": roomId,
        "users": [
          GlobalData.ins.currentUser!.userId,
          "2222"
          //GlobalData.ins.currentUser!.partner!.userId,
        ],
      }).catchError((e) {
        EasyLoading.showToast(e.toString());
      });
    }
  }
}
