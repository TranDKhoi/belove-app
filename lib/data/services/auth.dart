import 'package:belove_app/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../generated/l10n.dart';

class AuthService {
  AuthService._();

  static final ins = AuthService._();

  final fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;

  User? _userFromFireBase(fba.User? user) {
    return user == null
        ? null
        : User(
            userId: user.uid,
            email: user.email,
          );
  }

  Future signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      fba.UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      fba.User? firebaseUser = res.user;

      if (firebaseUser!.emailVerified == false) {
        await firebaseUser.sendEmailVerification();
        EasyLoading.showToast(S.current.verifyyouremail,
            duration: const Duration(seconds: 5));
        return;
      }

      return _userFromFireBase(firebaseUser);
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      fba.UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fba.User? firebaseUser = res.user;

      await firebaseUser!.sendEmailVerification();
      EasyLoading.showToast(S.current.verifyyouremail,
          duration: const Duration(seconds: 5));

      return _userFromFireBase(firebaseUser);
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future resetPass({required String email}) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }
}
