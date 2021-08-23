import '../exports.dart';

class AuthService {
  static late User? user;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static AuthService get instance => AuthService();

  Future<bool> isLogined() async {
    return _firebaseAuth.currentUser != null;
  }

  listenStateChange() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  register(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } catch (e) {
      throw e;
    }
  }

  verifyUserEmail() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  loginIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } catch (e) {
      throw e;
    }
  }

  signOut() async {
    await _firebaseAuth.signOut();
  }

  anonymousSignIn() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }
}
