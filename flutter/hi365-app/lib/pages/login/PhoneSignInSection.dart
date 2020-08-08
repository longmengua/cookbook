import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/authentication_bloc.dart';
import 'package:hi365/pages/authentication/authentication_event.dart';
import 'package:hi365/utils/api_provider.dart';
import 'package:hi365/utils/snackbars.dart';
import 'package:hi365/widgets/base_button.dart';
import 'package:flutter/services.dart';
//import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
//final GoogleSignIn _googleSignIn = GoogleSignIn();

class PhoneSignInSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PhoneSignInSectionState();
}

class _PhoneSignInSectionState extends State<PhoneSignInSection> {
  final ApiProvider _apiProvider = ApiProvider();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _countingMsg = '';
  String _verificationId;
  bool sendSmssignIsLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
            size: 30,
          ),
          onPressed: () =>
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
        ),
        title: Text(
          "手機登入",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(labelText: '請輸入手機電話號碼'),
                ),
                Text(
                  _message,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                OutlineButton(
                  onPressed: sendSmssignIsLock
                      ? null
                      : () => _verifyPhoneNumber(context),
                  child: Text('傳送驗證碼$_countingMsg'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _smsController,
                  decoration: const InputDecoration(labelText: '請輸入驗證碼'),
                ),
                SizedBox(
                  height: 20,
                ),
                BaseButton(
                  title: '登入',
                  onPressed: () {
                    if (!sendSmssignIsLock) {
                      _message = '尚未點擊傳送驗證碼。';
                      setState(() {});
                      return;
                    }
                    _signInWithPhoneNumber();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Example code of how to verify phone number
  void _verifyPhoneNumber(BuildContext ctx) async {
    _message = '';
    setState(() {});

    /// refers to https://firebase.google.com/docs/auth/android/phone-auth?authuser=0
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      if (phoneAuthCredential != null) {
        SnackBarBuilder.showSuccess(ctx, '驗證碼已驗證成功，系統登入中…');
        _signInWithCredentialAndRoute(phoneAuthCredential);
      }
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      if (authException.message.toLowerCase().contains('network error')) {
        _message = '網路連線異常。';
      } else if (authException.message.toLowerCase().contains('an internal error')) {
        _message = '網路連線異常。';
      } else if (authException.message.toLowerCase().contains('too_short')) {
        _message = '手機號碼不符合格式。';
      } else if (authException.message
          .toLowerCase()
          .contains('invalid format')) {
        _message = '手機號碼不符合格式。';
      } else if (authException.message.toLowerCase().contains('too_long')) {
        _message = '手機號碼不符合格式。';
      } else if (authException.message
          .toLowerCase()
          .contains('provided is incorrect')) {
        _message = '手機號碼不符合格式。';
      } else if (authException.message.toLowerCase().contains('have blocked')) {
        _message = '異常登入活動，我們將暫時鎖定此行動裝置登入權限。';
      } else {
        _message = '發生錯誤。(${authException.message})';
      }
      setState(() {});
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      sendSmssignIsLock = true;
      _message = '驗證碼已寄出，請確認簡訊。';
      _verificationId = verificationId;
      for (int i = 60; i >= 0; i--) {
        _countingMsg = '...倒數 $i 秒';
        setState(() {});
        await Future.delayed(Duration(seconds: 1));
      }
      sendSmssignIsLock = false;
      _message = '';
      _countingMsg = '';
      setState(() {});
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      setState(() {
        _message = '驗證碼逾時。';
      });
      _verificationId = verificationId;
    };

    print(_phoneNumberController.text);
    verifyPhoneNumber(_phoneNumberController.text);
    String phoneNumber =
        '+886${_phoneNumberController.text.substring(1, _phoneNumberController.text.length)}';
    print(phoneNumber);
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // Example code of how to sign in with phone.
  bool signIsLock = false;

  void _signInWithPhoneNumber() async {
    try {
      if (signIsLock) return;
      signIsLock = true;
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );
      _signInWithCredentialAndRoute(credential);
    } on PlatformException {
      signIsLock = false;
      setState(() {
        _message = '驗證碼錯誤。';
      });
    } catch (e) {
      signIsLock = false;
      setState(() {
        _message = '發生異常。($e)';
      });
    }
  }

  void _signInWithCredentialAndRoute(AuthCredential credential) async {
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    await _apiProvider.registerNewUserIntoHi365(user);
    BlocProvider.of<AuthenticationBloc>(context)
        .add(PhoneLoginSuccessfulState(user));
  }

  bool verifyPhoneNumber(String phoneNumber) {
    bool toReturn = false;
    if (phoneNumber.length == 10) {
      toReturn = true;
    }
    return toReturn;
  }
}
