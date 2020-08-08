import 'dart:async';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi365/pages/login/user_info_model.dart';
import 'package:hi365/utils/api_provider.dart';

class LoginProvider extends ApiProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    AuthResult result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Check if the user exists or do registration
    try {
      await registerNewUserIntoHi365(result.user);
    } catch (e) {
      throw DioError(error: '');
    }
    return result.user;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    FirebaseUser firebaseUser = await signInWithGoogleFromFirebase();
    await registerNewUserIntoHi365(firebaseUser);
    return firebaseUser;
  }

  Future<FirebaseUser> signInWithApple() async {
    FirebaseUser firebaseUser = await signInWithAppleFromLocalCredentail();
    await registerNewUserIntoHi365(firebaseUser);
    return firebaseUser;
  }

  Future<FirebaseUser> signInWithAppleFromLocalCredentail() async {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        // var appleUser = parseJwt(utf8.decode(result.credential.identityToken));
        String customToken = await _getCustomToken(result.credential);
        return (await _auth.signInWithCustomToken(token: customToken)).user;

      case AuthorizationStatus.error:
        print("Sign in failed: ${result.error.localizedDescription}");
        break;

      case AuthorizationStatus.cancelled:
        print('User cancelled');
        break;
    }
    return null;
  }

  Future<UserDetailsModel> getUserInfo() async => await client
      .get('/resource/api/user/user')
      .then((Response res) => UserDetailsModel.fromJson(res.data));

  Future<String> _getCustomToken(credential) async {
    final user = credential.user;
    final path =
        'https://us-central1-hi365-b2622.cloudfunctions.net/createUserFromCredential';
    final credentialDTO = {
      'user': user,
      'email': '$user@privaterelay.appleid.com',
    };

    return await Dio()
        .post(path, data: credentialDTO)
        .catchError((onError) => print(onError))
        .then((res) => res.data);
  }
}
