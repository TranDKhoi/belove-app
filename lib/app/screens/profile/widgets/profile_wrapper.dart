import 'package:belove_app/app/screens/profile/widgets/right_col.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/values/color.dart';
import 'left_col.dart';

class ProfileWrapper extends StatefulWidget {
  const ProfileWrapper({Key? key}) : super(key: key);

  @override
  State<ProfileWrapper> createState() => _ProfileWrapperState();
}

class _ProfileWrapperState extends State<ProfileWrapper> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LeftCol(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30)
                  .copyWith(bottom: 50),
              child: const Icon(
                Ionicons.heart,
                color: AppColors.primaryColor,
              ),
            ),
            const RightCol(),
          ],
        ),
      ],
    );
  }
}
