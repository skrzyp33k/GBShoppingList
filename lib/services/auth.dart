import 'package:firebase_auth/firebase_auth.dart';
import 'package:gb_shopping_list/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create User object

  UserModel? _createModel(User? user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            emailVerified: user.emailVerified,
            email: user.email)
        : null;
  }

  //auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_createModel);
  }

  //register with email and password

  Future registerEmail(
      {required String email, required String password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _createModel(user);
    } catch (ex) {
      return null;
    }
  }

  //sign in with email and password

  Future signInEmail({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _createModel(user);
    } catch (ex) {
      return null;
    }
  }

  //sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (ex) {
      return null;
    }
  }
}
