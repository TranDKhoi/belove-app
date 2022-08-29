import 'dart:async';

import '../../../../data/models/message.dart';
import '../../../../data/services/database.dart';

class ChatBloc {
  ChatBloc._();
  static final ins = ChatBloc._();

  List<Message>? messageList;

  //STREAM-----------------------------------------
  final StreamController<List<Message>> _messageStreamController =
      StreamController<List<Message>>();

  Stream<List<Message>> get messageStream => _messageStreamController.stream;

  //----------------------------------------------------

//EVENT---------------------------------------------------

  sendMessage(String mess) async {
    await DataBaseService.ins
        .sendMessage(Message(message: mess), DateTime.now());
  }

  void dispose() {
    _messageStreamController.close();
  }
}
