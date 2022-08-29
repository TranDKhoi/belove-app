import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/anniversary.dart';
import 'package:belove_app/data/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../models/message.dart';
import '../models/user.dart';

class DataBaseService {
  DataBaseService._();

  static final ins = DataBaseService._();

  final _store = FirebaseFirestore.instance;

  var lastDoc;
  var lastMess;

  String _getCoupleId() {
    if (GlobalData.ins.currentUser!.gender == 0) {
      return GlobalData.ins.currentUser!.userId! +
          GlobalData.ins.currentUser!.partnerId!;
    }
    return GlobalData.ins.currentUser!.partnerId! +
        GlobalData.ins.currentUser!.userId!;
  }

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

  createChatRoom() async {
    String roomId = _getCoupleId();

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
    String roomId = _getCoupleId();

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
    var roomid = _getCoupleId();

    return FirebaseFirestore.instance
        .collection('chat_room')
        .doc(roomid)
        .collection("message")
        .orderBy("id", descending: true)
        .snapshots();
  }

  createAnniversary(DateTime day) async {
    String anniverId = _getCoupleId();

    await _store.collection("anniversary").doc(anniverId).set({
      "beginDate": day,
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  getAnniversary() async {
    String anniverId = _getCoupleId();

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

  createTimeLine() async {
    String timeLineId = _getCoupleId();

    await _store
        .collection("timeline")
        .doc(timeLineId)
        .collection("posts")
        .doc("initDoc")
        .set({
      "error": "error",
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  createPost(title, List<String>? links, DateTime createdAt) async {
    String timeLineId = _getCoupleId();

    List<String>? tempLink;
    if (links != null) {
      tempLink = links;
    }
    await _store
        .collection("timeline")
        .doc(timeLineId)
        .collection("posts")
        .doc(createdAt.toString())
        .set({
      "id": createdAt.toString(),
      "posterId": GlobalData.ins.currentUser!.userId,
      "title": title ?? "",
      "images": tempLink,
    }).catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }

  Future getPosts() async {
    String timeLineId = _getCoupleId();

    var query = await _store
        .collection("timeline")
        .doc(timeLineId)
        .collection("posts")
        .orderBy("id", descending: true)
        .limit(10)
        .get()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = query.docs;

    if (data.isNotEmpty) {
      lastDoc = query.docs[query.docs.length - 1];
      return data.map((e) {
        List<dynamic> imgMap = e.data()["images"];
        List<String>? imgList;
        if (imgMap.isNotEmpty) {
          imgList = imgMap.map((e) => e.toString()).toList();
        }

        return Post(
          id: e.id,
          posterId: e.get("posterId"),
          createdAt: DateTime.parse(e.get("id")),
          title: e.get("title"),
          images: imgList,
        );
      }).toList();
    }
    return null;
  }

  Future getMorePosts() async {
    String timeLineId = _getCoupleId();

    final nextQuery = await _store
        .collection("timeline")
        .doc(timeLineId)
        .collection("posts")
        .orderBy("id", descending: true)
        .limit(10)
        .startAfterDocument(lastDoc)
        .get()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });

    final data = nextQuery.docs;

    if (data.isNotEmpty) {
      lastDoc = nextQuery.docs[nextQuery.docs.length - 1];
      return data.map((e) {
        List<dynamic> imgMap = e.data()["images"];
        List<String>? imgList;
        if (imgMap.isNotEmpty) {
          imgList = imgMap.map((e) => e.toString()).toList();
        }

        return Post(
          id: e.id,
          posterId: e.get("posterId"),
          createdAt: DateTime.parse(e.get("id")),
          title: e.get("title"),
          images: imgList,
        );
      }).toList();
    }
    return null;
  }
}
