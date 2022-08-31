import 'dart:async';

import 'package:belove_app/app/global_data/global_data.dart';
import 'package:belove_app/app/global_data/global_key.dart';
import 'package:belove_app/data/models/anniversary.dart';
import 'package:belove_app/data/services/database/anniversary_base.dart';

class SideBarBloc {
  SideBarBloc._();

  static final ins = SideBarBloc._();

  //STREAM-------------------------------------
  final StreamController<List<Anniversary>> _anniverStreamController =
      StreamController<List<Anniversary>>.broadcast();

  Stream<List<Anniversary>> get anniverStream =>
      _anniverStreamController.stream;

  // -------------------------------------------
  //DATA----------------------------------------
  DateTime? pickedDate;
  List<Anniversary>? anniList;

  //--------------------------------------------

  createBeginDay() async {
    if (pickedDate == null) return;
    await AnniversaryBaseService.ins.uploadAnniversary(Anniversary(
      title: " years anniversary",
      date: pickedDate!,
    ));
    pickedDate == null;
    getAnniversary();
  }

  updateBeginDay() async {
    if (pickedDate == null) return;
    await AnniversaryBaseService.ins.updateAnniversary(pickedDate);
    pickedDate == null;
    getAnniversary();
  }

  getAnniversary() async {
    var res = await AnniversaryBaseService.ins.getAnniversary();
    if (res != null) {
      anniList = res;

      for (int i = 0; i < res.length; i++) {
        if (res[i].title == " years anniversary") {
          GlobalData.ins.ourDay = res[i];
        }
        break;
      }

      _anniverStreamController.sink.add(anniList!);
    }
  }

  deleteAnniversary(anniId) async {
    await AnniversaryBaseService.ins.deleteAnniversary(anniId);
    getAnniversary();
  }

  uploadAnniversary(title, date) async {
    var newAni = Anniversary(title: title, date: date);
    await AnniversaryBaseService.ins.uploadAnniversary(newAni);
    getAnniversary();
    navigatorKey.currentState?.pop();
  }

  void dispose() {
    _anniverStreamController.close();
    pickedDate = null;
  }
}
