import 'dart:io';

import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/app/screens/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';
import '../../../core/values/color.dart';

class SendImageDialog extends StatelessWidget {
  const SendImageDialog({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(8),
      content: Wrap(
        children: [
          Center(child: Image.file(File(imagePath))),
          const Divider(
            color: AppColors.primaryColor,
            endIndent: 0,
            thickness: 0.8,
          ),
          GestureDetector(
            onTap: () async {
              ChatBloc.ins.sendImage(imagePath);
              navigatorKey.currentState?.pop();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Ionicons.checkmark_circle_outline,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    S.of(context).send,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
