import 'dart:async';
import 'dart:io';

import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/route.dart';
import 'package:belove_app/data/services/database/chat_base.dart';
import 'package:belove_app/data/services/notification.dart';
import 'package:belove_app/data/services/store.dart';

import '../../../data/models/message.dart';

class ChatBloc {
  ChatBloc._() {
    isFirstTime = true;
  }

  static final ins = ChatBloc._();

  List<Message> messageList = [];

  bool isInChatScreen = false;
  bool? isFirstTime;

  //STREAM-----------------------------------------
  final StreamController<List<Message>> _messageStreamController =
      StreamController<List<Message>>.broadcast();

  Stream<List<Message>> get messageStream => _messageStreamController.stream;

  Stream newMessageListener = ChatBaseService.ins.listenerMessage();
  StreamSubscription? subscription;

  //----------------------------------------------------

  //EVENT---------------------------------------------------

  sendMessage(String mess) async {
    await ChatBaseService.ins
        .sendMessage(Message(message: mess), DateTime.now());
  }

  sendImage(String image) async {
    var time = DateTime.now();
    var res = await StoreService.ins.uploadChatImage(File(image), time);
    await ChatBaseService.ins.sendMessage(Message(image: res), time);
    await getMessage();
  }

  getMessage() async {
    var res = await ChatBaseService.ins.getMessage();

    if (res != null) {
      messageList = [];
      messageList.addAll(res);
      _messageStreamController.sink.add(messageList);
    }
  }

  getMoreMessage() async {
    var res = await ChatBaseService.ins.getMoreMessage();

    if (res != null) {
      messageList.addAll(res);
      _messageStreamController.sink.add(messageList);
    }
  }

  listenToMessage() async {
    subscription = newMessageListener.listen((event) {
      var messMap = event.docs;
      Message messItem = Message(
        id: messMap.first["id"],
        senderId: messMap.first["senderId"],
        message: messMap.first["message"],
        image: messMap.first["image"],
      );

      showNotify(messItem);

      messageList.insert(0, messItem);
      _messageStreamController.sink.add(messageList);
    });
  }

  void dispose() {
    isFirstTime = true;
  }

  void showNotify(Message messItem) {
    final pushNotification = PushNotificationService.ins;

    if (messItem.senderId == GlobalData.ins.currentUser!.userId) return;
    if (isInChatScreen) return;

    if (isFirstTime!) {
      isFirstTime = false;
      return;
    }
    pushNotification.showMessageNotification(
        id: 0,
        title: GlobalData.ins.currentUser!.partner!.name,
        body: messItem.message ?? "Image",
        payload: chatScreen);
  }
}
