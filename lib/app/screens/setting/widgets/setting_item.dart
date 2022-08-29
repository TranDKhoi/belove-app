import 'package:belove_app/app/core/values/color.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem(
      {Key? key, required this.onTap, required this.icon, required this.title})
      : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.primaryColor,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
