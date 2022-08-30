import 'package:belove_app/app/screens/home/home_bloc.dart';
import 'package:belove_app/app/screens/home/home_inherited.dart';
import 'package:belove_app/app/screens/home/widgets/timeline.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../generated/l10n.dart';
import '../../../global_data/global_data.dart';
import 'add_post_form.dart';
import 'header.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  late HomeBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = HomeInherited.of(context).bloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //HEADER
        const HomeHeader(),
        //TIMELINE
        if (GlobalData.ins.currentUser!.partner != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return const AddPostForm();
                        });
                    _bloc.getPost();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Row(
                        children: [
                          Icon(
                            Ionicons.add_outline,
                            color: Colors.grey[400],
                          ),
                          Text(
                            S.of(context).morepost,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        const HomeTimeLine(),
      ],
    );
  }
}
