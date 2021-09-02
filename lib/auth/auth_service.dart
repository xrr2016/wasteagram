import '../exports.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // userService.save(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw e;
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

  signIn(String email, String password) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // UserModel userModel = UserModel(
      //   displayName: credential.user.displayName,
      // );

      // userService.save(userModel);
      debugPrint(credential.user.toString());
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  logOut() async {
    await _firebaseAuth.signOut();
    userService.remove();
  }

  anonymousSignIn() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      // userService.save(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }
}

final AuthService authService = AuthService();
