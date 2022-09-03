import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/core/values/color.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendMessageItem extends StatefulWidget {
  const SendMessageItem({Key? key, required this.item}) : super(key: key);

  final Message item;

  @override
  State<SendMessageItem> createState() => _SendMessageItemState();
}

class _SendMessageItemState extends State<SendMessageItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: 30, maxWidth: context.screenSize.width / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isClicked = !isClicked;
                      });
                    },
                    child: Card(
                      color: AppColors.primaryColor,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                            .copyWith(topRight: Radius.zero),
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
                  if (isClicked)
                    Text(DateFormat.Hm()
                        .format(DateTime.parse(widget.item.id!))),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GlobalData.ins.currentUser!.avatar != ""
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          Image.network(GlobalData.ins.currentUser!.avatar!)
                              .image,
                    ),
                  ],
                )
              : CircleAvatar(
                  child: Image.asset(
                    "assets/images/${GlobalData.ins.currentUser!.gender == 0 ? "boy" : "girl"}.png",
                  ),
                ),
        ],
      ),
    );
  }
}
