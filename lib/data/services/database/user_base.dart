import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../models/user.dart';

class UserBaseService {
  UserBaseService._();

  static final ins = UserBaseService._();

  final _store = FirebaseFirestore.instance;
  //-----------------------------------------------------------
  dynamic getUserById(String id) async {
    var query = await _store.collection("users").doc(id).get().catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.data();
    if (data != null) {
      DateTime? tempBirth;
      if (data["birthday"] != "") {
        tempBirth = data["birthday"].toDate();
      }
      return User(
        userId: data["userId"],
        email: data["email"],
        birthday: tempBirth,
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
}
