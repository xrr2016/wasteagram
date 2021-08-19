import '../exports.dart';

class AuthService {
  listenStateChange() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      debugPrint(userCredential.user.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  verifyUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      debugPrint(userCredential.user.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  anonymousSignIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      debugPrint(userCredential.user.toString());
    } on FirebaseAuthException catch (e) {
      print(e.code);
    } catch (e) {
      print(e);
    }
  }
}
