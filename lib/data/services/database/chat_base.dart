import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../app/core/utils/utils.dart';
import '../../../app/global_data/global_data.dart';
import '../../models/message.dart';

class ChatBaseService {
  ChatBaseService._();

  static final ins = ChatBaseService._();

  final _store = FirebaseFirestore.instance;
  var lastMess;

//----------------------------------------------------------

  createChatRoom() async {
    String roomId = getCoupleId();

    //check if room is existed
    var query =
        await _store.collection("chat_room").doc(roomId).get().catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    if (!query.exists) {
      await _store
          .collection("chat_room")
          .doc(roomId)
          .collection("message")
          .doc("initMessage")
          .set({
        "init": "init",
      }).catchError((e) {
        EasyLoading.showToast(e.toString());
      });
    }
  }

  sendMessage(Message newMess, DateTime createdAt) async {
    String roomId = getCoupleId();

    await _store
        .collection("chat_room")
        .doc(roomId)
        .collection("message")
        .doc(createdAt.toString())
        .set({
      "id": createdAt.toString(),
      "message": newMess.message,
      "senderId": GlobalData.ins.currentUser!.userId,
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenerMessage() {
    var roomid = getCoupleId();
    return FirebaseFirestore.instance
        .collection('chat_room')
        .doc(roomid)
        .collection("message")
        .orderBy("id", descending: true)
        .limit(1)
        .snapshots();
  }

  getMessage() async {
    var roomid = getCoupleId();

    var query = await _store
        .collection("chat_room")
        .doc(roomid)
        .collection("message")
        .orderBy("id", descending: true)
        .limit(10)
        .get()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.docs;

    if (data.isNotEmpty) {
      lastMess = query.docs[query.docs.length - 1];
      return data.map((e) {
        return Message(
          id: e.id,
          message: e.get("message"),
          senderId: e.get("senderId"),
        );
      }).toList();
    }
    return null;
  }

  getMoreMessage() async {
    var roomid = getCoupleId();

    var query = await _store
        .collection("chat_room")
        .doc(roomid)
        .collection("message")
        .orderBy("id", descending: true)
        .limit(10)
        .startAfterDocument(lastMess)
        .get()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.docs;

    if (data.isNotEmpty) {
      lastMess = query.docs[query.docs.length - 1];
      return data.map((e) {
        return Message(
          id: e.id,
          message: e.get("message"),
          senderId: e.get("senderId"),
        );
      }).toList();
    }
    return null;
  }
}
