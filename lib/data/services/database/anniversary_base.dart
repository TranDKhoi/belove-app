import 'package:belove_app/app/global_data/global_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../app/core/utils/utils.dart';
import '../../models/anniversary.dart';

class AnniversaryBaseService {
  AnniversaryBaseService._();

  static final ins = AnniversaryBaseService._();

  final _store = FirebaseFirestore.instance;

  //---------------------------------------------------
  createAnniversaryCollection() async {
    String anniverId = getCoupleId();

    await _store
        .collection("anniversary")
        .doc(anniverId)
        .collection("memory")
        .doc("init")
        .set({
      "init": "init",
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  uploadAnniversary(Anniversary ani) async {
    String anniverId = getCoupleId();
    String docId = DateTime.now().toString();

    await _store
        .collection("anniversary")
        .doc(anniverId)
        .collection("memory")
        .doc(docId)
        .set({
      "id": docId,
      "title": ani.title,
      "date": ani.date,
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  updateAnniversary(pickedDate) async {
    String anniverId = getCoupleId();
    String docId = DateTime.now().toString();

    await _store
        .collection("anniversary")
        .doc(anniverId)
        .collection("memory")
        .doc(GlobalData.ins.ourDay!.id)
        .update({"date": pickedDate}).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  getAnniversary() async {
    String anniverId = getCoupleId();

    var query = await _store
        .collection("anniversary")
        .doc(anniverId)
        .collection("memory")
        .orderBy("id")
        .get()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.docs;

    if (data.isNotEmpty) {
      return data
          .map(
            (e) => Anniversary(
              id: e.get("id"),
              title: e.get("title"),
              date: e.get("date").toDate(),
            ),
          )
          .toList();
    }
    return null;
  }

  deleteAnniversary(id) async {
    String anniverId = getCoupleId();

    await _store
        .collection("anniversary")
        .doc(anniverId)
        .collection("memory")
        .doc(id)
        .delete()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }
}
