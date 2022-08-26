import '../../data/models/user.dart';

class GlobalData {
  GlobalData._();

  static final ins = GlobalData._();

  User? currentUser;
}
