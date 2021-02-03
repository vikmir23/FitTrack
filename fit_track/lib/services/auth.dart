import 'package:fit_track/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _convertfbUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map((_convertfbUser));
  }

  //register with email
  Future registerEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _convertfbUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email
  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;
      return _convertfbUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //TODO additional auth methods google etc
}
