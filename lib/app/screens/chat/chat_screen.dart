import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/screens/chat/chat_bloc.dart';
import 'package:belove_app/app/screens/chat/widgets/chatbar.dart';
import 'package:belove_app/app/screens/chat/widgets/receive_item.dart';
import 'package:belove_app/app/screens/chat/widgets/send_item.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/models/message.dart';
import '../../../generated/l10n.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _bloc = ChatBloc.ins;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _bloc.getMessage();
    _bloc.messageList = [];
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _bloc.getMoreMessage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(GlobalData.ins.currentUser!.partner?.name == null
              ? "..."
              : GlobalData.ins.currentUser!.partner!.name!),
          actions: [
            GestureDetector(onTap: () {}, child: const Icon(Ionicons.call)),
            const SizedBox(width: 20),
            GestureDetector(onTap: () {}, child: const Icon(Ionicons.videocam)),
            const SizedBox(width: 20),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.screenSize.height * 0.1),
              child: StreamBuilder(
                  stream: _bloc.messageStream,
                  builder: (context, AsyncSnapshot<List<Message>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          S.of(context).sendyourfirst,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }
                    return ListView(
                      reverse: true,
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      children:
                          List.generate(_bloc.messageList.length, (index) {
                        var messItem = _bloc.messageList[index];
                        if (messItem.senderId ==
                            GlobalData.ins.currentUser!.userId) {
                          return SendMessageItem(item: messItem);
                        }
                        return ReceivedMessageItem(item: messItem);
                      }),
                    );
                  }),
            ),
            const ChatBar(),
          ],
        ));
  }
}
