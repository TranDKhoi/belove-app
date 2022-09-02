import 'package:belove_app/app/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/message.dart';
import '../../../global_data/global_data.dart';

class ReceivedMessageItem extends StatefulWidget {
  const ReceivedMessageItem({Key? key, required this.item}) : super(key: key);

  final Message item;

  @override
  State<ReceivedMessageItem> createState() => _ReceivedMessageItemState();
}

class _ReceivedMessageItemState extends State<ReceivedMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalData.ins.currentUser!.partner!.avatar != ""
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(
                              GlobalData.ins.currentUser!.partner!.avatar!)
                          .image,
                    ),
                  ],
                )
              : CircleAvatar(
                  child: Image.asset(
                    "assets/images/${GlobalData.ins.currentUser!.partner!.gender == 0 ? "boy" : "girl"}.png",
                  ),
                ),
          const SizedBox(width: 10),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 30,
                maxWidth: context.screenSize.width / 2,
              ),
              child: Card(
                elevation: 10,
                color: Colors.grey[500],
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10).copyWith(topLeft: Radius.zero),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: widget.item.message != null
                      ? Text(
                          widget.item.message!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : widget.item.image == null
                          ? const Center()
                          : Image.network(widget.item.image!),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
