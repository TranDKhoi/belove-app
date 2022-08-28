import 'dart:async';

import 'package:belove_app/app/core/utils/utils.dart';
import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/data/models/anniversary.dart';

import '../../../../data/services/database.dart';

class SideBarBloc {
  SideBarBloc._();

  static final ins = SideBarBloc._();

  //STREAM-------------------------------------
  final StreamController<int> _beginDayStreamController =
      StreamController<int>.broadcast();

  Stream<int> get beginDayStream => _beginDayStreamController.stream;

  // -------------------------------------------
  //DATA----------------------------------------
  DateTime? pickedDate;

  //--------------------------------------------

  uploadBeginDay() async {
    await DataBaseService.ins.createAnniversary(pickedDate!);
    Anniversary? res = await DataBaseService.ins.getAnniversary();

    if (res != null) {
      GlobalData.ins.ourDay = res;
      _beginDayStreamController.sink.add(countDay(res.beginDate!));
    }
  }

  void dispose() {
    _beginDayStreamController.close();
    pickedDate = null;
  }
}
