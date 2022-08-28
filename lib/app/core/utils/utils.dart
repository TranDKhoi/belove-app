import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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

int howManyDayLeft(DateTime day) {
  var tempDay = DateTime(DateTime.now().year, day.month, day.day);
  if (tempDay.difference(DateTime.now()).inDays < 0) {
    return DateTime.now()
            .difference(
                DateTime(DateTime.now().year + 1, tempDay.month, tempDay.day))
            .inDays
            .abs() +
        1;
  }
  return DateTime.now().difference(tempDay).inDays.abs() + 1;
}

int countYear(DateTime day) {
  return (DateTime.now().year - day.year).abs();
}

int countDay(DateTime beginDay) {
  return DateTime.now().difference(beginDay).inDays + 1;
}

class ImageHelper {
  ImageHelper._();

  static final ins = ImageHelper._();
  final ImagePicker imgPicker = ImagePicker();

  Future<String?> pickAvatar() async {
    final XFile? selected =
        await imgPicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      return await cropImage(selected.path);
    }
    return null;
  }

  Future<List<String>?> pickMultiImage() async {
    final List<XFile>? selected = await imgPicker.pickMultiImage();

    if (selected != null) {
      return selected.map((e) => e.path).toList();
    }
    return null;
  }

  Future<String?> pickSingleImage() async {
    final XFile? selected =
        await imgPicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      return selected.path;
    }
    return null;
  }

  Future<String?> cropImage(String path) async {
    CroppedFile? cropped = await ImageCropper()
        .cropImage(sourcePath: path, cropStyle: CropStyle.circle);

    if (cropped != null) {
      return cropped.path;
    }
    return null;
  }
}
