import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/anniversary.dart';
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
        birthday: data["birthday"].toDate(),
        name: data["name"],
        gender: data["gender"],
        partnerId: data["partnerId"],
        avatar: data["avatar"],
      );
    }
    return null;
  }

  uploadUserInfo(User user) async {
    await _store.collection("users").doc(user.userId).set({
      "userId": user.userId,
      "email": user.email,
      "partnerId": user.partnerId ?? "",
      "name": user.name ?? "",
      "birthday": user.birthday ?? "",
      "gender": user.gender ?? -1,
      "avatar": user.avatar ?? "",
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  createChatRoom() async {
    String roomId = "";

    if (GlobalData.ins.currentUser!.gender == 0) {
      roomId = GlobalData.ins.currentUser!.userId! +
          GlobalData.ins.currentUser!.partnerId!;
    } else if (GlobalData.ins.currentUser!.gender == 1) {
      roomId = GlobalData.ins.currentUser!.partnerId! +
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
          GlobalData.ins.currentUser!.partnerId,
          //GlobalData.ins.currentUser!.partner!.userId,
        ],
      }).catchError((e) {
        EasyLoading.showToast(e.toString());
      });
    }
  }

  dynamic getAnniversary() async {
    String anniverId = "";

    if (GlobalData.ins.currentUser!.gender == 0) {
      anniverId = GlobalData.ins.currentUser!.userId! +
          GlobalData.ins.currentUser!.partnerId!;
    } else if (GlobalData.ins.currentUser!.gender == 1) {
      anniverId = GlobalData.ins.currentUser!.partnerId! +
          GlobalData.ins.currentUser!.userId!;
    }
    var query = await _store
        .collection("anniversary")
        .doc(anniverId)
        .get()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.data();
    if (data != null) {
      return Anniversary(
        beginDate: data["beginDate"].toDate(),
      );
    }
    return null;
  }

  createAnniversary(DateTime day) async {
    String anniverId = "";

    if (GlobalData.ins.currentUser!.gender == 0) {
      anniverId = GlobalData.ins.currentUser!.userId! +
          GlobalData.ins.currentUser!.partnerId!;
    } else if (GlobalData.ins.currentUser!.gender == 1) {
      anniverId = GlobalData.ins.currentUser!.partnerId! +
          GlobalData.ins.currentUser!.userId!;
    }

    await _store.collection("anniversary").doc(anniverId).set({
      "beginDate": day,
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }
}
