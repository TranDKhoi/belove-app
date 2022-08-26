import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../values/color.dart';

extension GetScreenSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}

void configEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.white.withOpacity(0.1)
    ..indicatorColor = AppColors.primaryColor
    ..userInteractions = true
    ..dismissOnTap = false
    ..textColor = Colors.black
    ..textColor = Colors.white
    ..toastPosition = EasyLoadingToastPosition.center;
}

String dateFormat(DateTime date) {
  String formatTime = "${date.day}-${date.month}-${date.year}";
  return formatTime;
}
