import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

mixin FirebaseAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuth get auth => _auth;

  Future<FirebaseUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<FirebaseUser> signInWithGoogleFromFirebase() async {
    // Renew the instance or it will not work anymore after logout
    _googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return (await _auth.signInWithCredential(credential)).user;
  }

  Future<FirebaseUser> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await auth.signOut();
  }
}
