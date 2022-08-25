import 'package:belove_app/app/core/utils/utils.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'app/screens/my_app/app.dart';

void main() {
  configEasyLoading();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}
