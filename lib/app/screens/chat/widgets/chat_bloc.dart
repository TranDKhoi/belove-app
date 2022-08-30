import 'dart:async';

import '../../../../data/models/message.dart';
import '../../../../data/services/database.dart';

class ChatBloc {
  ChatBloc._() {
    listenToMessage();
  }

  static final ins = ChatBloc._();

  List<Message> messageList = [];

  //STREAM-----------------------------------------
  final StreamController<List<Message>> _messageStreamController =
      StreamController<List<Message>>.broadcast();

  Stream<List<Message>> get messageStream => _messageStreamController.stream;

  Stream newMessageListener = DataBaseService.ins.listenerMessage();

  //----------------------------------------------------

//EVENT---------------------------------------------------

  sendMessage(String mess) async {
    await DataBaseService.ins
        .sendMessage(Message(message: mess), DateTime.now());
  }

  getMessage() async {
    var res = await DataBaseService.ins.getMessage();

    if (res != null) {
      messageList.addAll(res);
      _messageStreamController.sink.add(messageList);
    }
  }

  getMoreMessage() async {
    var res = await DataBaseService.ins.getMoreMessage();

    if (res != null) {
      messageList.addAll(res);
      _messageStreamController.sink.add(messageList);
    }
  }

  listenToMessage() {
    newMessageListener.listen((event) {
      var messMap = event.docs;
      Message messItem = Message(
        id: messMap.first["id"],
        senderId: messMap.first["senderId"],
        message: messMap.first["message"],
      );
      messageList.insert(0, messItem);
      _messageStreamController.sink.add(messageList);
    });
  }

  void dispose() {
    _messageStreamController.close();
  }
}
