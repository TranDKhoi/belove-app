import 'package:belove_app/data/models/anniversary.dart';

import '../../data/models/user.dart';

class GlobalData {
  GlobalData._();

  static final ins = GlobalData._();

  User? currentUser;
  Anniversary? ourDay;
}
