import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/screens/chat/widgets/chat_bloc.dart';
import 'package:belove_app/app/screens/chat/widgets/chatbar.dart';
import 'package:belove_app/app/screens/chat/widgets/receive_item.dart';
import 'package:belove_app/app/screens/chat/widgets/send_item.dart';
import 'package:belove_app/data/models/message.dart';
import 'package:belove_app/data/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../generated/l10n.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scollController = ScrollController();
  final _bloc = ChatBloc.ins;

  @override
  void initState() {
    //_bloc.getMessage();

    super.initState();
  }

  @override
  void dispose() {
    // _bloc.dispose();
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
                  stream: DataBaseService.ins.listenerMessage(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                            S.of(context).sendyourfirst,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      var messMap = snapshot.data!.docs;
                      return ListView(
                        reverse: true,
                        controller: _scollController,
                        physics: const BouncingScrollPhysics(),
                        children:
                            List.generate(snapshot.data!.docs.length, (index) {
                          Message messItem = Message(
                            id: messMap[index]["id"],
                            message: messMap[index]["message"],
                            senderId: messMap[index]["senderId"],
                          );
                          if (messItem.senderId ==
                              GlobalData.ins.currentUser!.userId) {
                            return SendMessageItem(item: messItem);
                          }
                          return ReceivedMessageItem(item: messItem);
                        }),
                      );
                    }
                    return const SizedBox();
                  }),
            ),
            const ChatBar(),
          ],
        ));
  }
}
