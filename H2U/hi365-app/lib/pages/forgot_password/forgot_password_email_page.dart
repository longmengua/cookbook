import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/utils/app_configs.dart';
import 'package:hi365/utils/snackbars.dart';
import 'package:hi365/widgets/base_button.dart';
import 'package:hi365/widgets/text_form_field_builder.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  static const String routeName = "/forgotPassword";

  @override
  _ForgotPasswordEmailPageState createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final TextEditingController _emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isNotSubmitted = true;

  @override
  void initState() {
    super.initState();
    _emailController.value = TextEditingValue(
        text: BlocProvider.of<AuthenticationBloc>(context)?.user?.email ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar(),
      body: _showBody(),
    );
  }

  Widget _showAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        iconSize: 30.0,
        color: AppConfig().primaryColor,
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        "修改密碼",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _showBody() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showEmailField(),
          Builder(
            builder: (context) => BaseButton(
              title: '索取密碼更改確認信',
              onPressed: _emailController.text.isNotEmpty && isNotSubmitted
                  ? () => _askAuthMail(context)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _askAuthMail(BuildContext context) async {
    setState(() {
      SnackBarBuilder.showLoading(context, '資料正在處理中…');
      isNotSubmitted = false;
      FocusScope.of(context).requestFocus(new FocusNode());
    });
    await _auth
        .sendPasswordResetEmail(email: _emailController.text)
        .then((onValue) => SnackBarBuilder.showSuccess(context, '郵件已送出。'))
        .then((onValue) => Future.delayed(Duration(seconds: 3)))
        .then((onValue) =>
            SnackBarBuilder.showSuccess(context, '系統將執行登出作業，請於修改後重新登入。'))
        .then((onValue) => Future.delayed(Duration(seconds: 3)))
        .then((onValue) => Navigator.of(context).pop())
        .then((onValue) =>
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()))
        .catchError(
      (onError) {
        setState(
          () {
            print('修改密碼請求失敗: $onError');
            String errorMessage = '操作失敗';
            isNotSubmitted = true;
            if (onError.code == 'ERROR_USER_NOT_FOUND') {
              errorMessage = '找不到您的Hi365帳戶';
            }
            SnackBarBuilder.showError(context, errorMessage);
          },
        );
      },
    );
  }

  Widget _showEmailField() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextFormFieldBuilder(
        onChanged: (text) => setState(() {}),
        labelText: '電子郵件',
        hintText: '請輸入您的電子郵件',
        controller: _emailController,
        validateFailureMessage:
            _emailController.text == null ? 'Invalid Email' : null,
      ),
    );
  }
}
