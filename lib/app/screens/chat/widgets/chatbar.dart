import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/screens/chat/chat_bloc.dart';
import 'package:belove_app/app/screens/chat/widgets/send_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatBar extends StatefulWidget {
  const ChatBar({Key? key}) : super(key: key);

  @override
  State<ChatBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  final _messController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenSize.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                var res = await ImageHelper.ins.pickSingleImage();
                if (res != null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SendImageDialog(imagePath: res);
                      });
                }
              },
              child: const Icon(
                Ionicons.image_outline,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _messController,
                onChanged: (val) {
                  setState(() {});
                },
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      ChatBloc.ins.sendMessage(_messController.text.trim());
                      _messController.clear();
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _messController.text.isNotEmpty
                          ? const Icon(Ionicons.send)
                          : null,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
