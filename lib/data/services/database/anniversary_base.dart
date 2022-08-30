import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../app/core/utils/utils.dart';
import '../../models/anniversary.dart';

class AnniversaryBaseService {
  AnniversaryBaseService._();

  static final ins = AnniversaryBaseService._();

  final _store = FirebaseFirestore.instance;
  //---------------------------------------------------
  createAnniversary(DateTime day) async {
    String anniverId = getCoupleId();

    await _store.collection("anniversary").doc(anniverId).set({
      "beginDate": day,
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  getAnniversary() async {
    String anniverId = getCoupleId();

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
}
