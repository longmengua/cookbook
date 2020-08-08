import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/pages/forgot_password/forgot_password_email_page.dart';
import 'package:hi365/pages/login/index.dart';
import 'package:hi365/utils/app_configs.dart';
import 'package:hi365/utils/snackbars.dart';
import 'package:hi365/widgets/base_button.dart';
import 'package:hi365/widgets/text_form_field_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) =>
      isPopulated && !state.isSubmitting;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: _blocListenerHandler,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: _blocBuilderHandler,
      ),
    );
  }

  void _blocListenerHandler(BuildContext context, LoginState state) {
    if (state.isFailure) {
      SnackBarBuilder.showError(context, '帳號或密碼錯誤，請重新登入');
    } else if (state.isSubmitting) {
      SnackBarBuilder.showLoading(context, '資料讀取中...');
    } else if (state.isSuccess) {
      BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn(state.user));
    }
  }

  Widget _blocBuilderHandler(BuildContext context, LoginState state) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              _showEmailField(state),
              _showPasswordField(state),
              _showButtonList(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showEmailField(LoginState state) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: TextFormFieldBuilder(
        labelText: '電子郵件',
        hintText: '請輸入您的電子郵件',
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validateFailureMessage: null,
      ),
    );
  }

  Widget _showPasswordField(LoginState state) {
    return TextFormFieldBuilder(
      type: FieldType.PASSWORD,
      labelText: '密碼',
      hintText: '請輸入密碼',
      controller: _passwordController,
      validateFailureMessage: null,
    );
  }

  Widget _showButtonList(LoginState state) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _showLoginButton(
            title: '登入',
            onPressed: isLoginButtonEnabled(state) ? _onFormSubmitted : null,
          ),
          SizedBox(
            height: 15,
          ),
          BaseButton(
            title: '註冊',
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                .add(GoToRegisterPage()),
          ),
          _showForgotPassword(),
        ],
      ),
    );
  }

  Widget _showLoginButton({
    String title,
    VoidCallback onPressed,
  }) {
    return BaseButton(
      title: title,
      onPressed: onPressed,
    );
  }

  Widget _showForgotPassword() {
    return Padding(
      padding: EdgeInsets.only(top: 25.0),
      child: Center(
        child: FlatButton(
          child: Text(
            '忘記密碼',
            style: TextStyle(
              fontSize: 16.0,
              color: AppConfig().primaryColor,
            ),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ForgotPasswordEmailPage(),
            ),
          ),
        ),
      ),
    );
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
