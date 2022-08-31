import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../app/core/utils/utils.dart';
import '../../../app/global_data/global_data.dart';
import '../../models/post.dart';

class TimelineBaseService {
  TimelineBaseService._();

  static final ins = TimelineBaseService._();

  final _store = FirebaseFirestore.instance;
  var lastDoc;

  //-----------------------------------------------------------
  createTimeLineCollection() async {
    String timeLineId = getCoupleId();

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
    String timeLineId = getCoupleId();

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
    String timeLineId = getCoupleId();

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
    try {
      String timeLineId = getCoupleId();

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
    } catch (e) {
      log("error: $e");
    }
    return null;
  }

  deletePost(String postId) async {
    String timeLineId = getCoupleId();

    await _store
        .collection("timeline")
        .doc(timeLineId)
        .collection("posts")
        .doc(postId)
        .delete()
        .catchError((e) {
      EasyLoading.showToast(e.toString());
    });
  }
}
