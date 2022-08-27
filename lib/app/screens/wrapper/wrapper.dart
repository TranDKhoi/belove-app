import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/services/database.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(GlobalData.ins.currentUser!.email!),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DataBaseService.ins.createChatRoom();
        },
        child: const Icon(Icons.mail_outline_rounded),
      ),
    );
  }
}
