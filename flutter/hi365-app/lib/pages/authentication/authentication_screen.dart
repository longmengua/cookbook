import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/authentication/choices_screen.dart';
import 'package:hi365/pages/authentication/index.dart';
import 'package:hi365/pages/authentication/splash_screen.dart';
import 'package:hi365/pages/home/index.dart';
import 'package:hi365/pages/login/PhoneSignInSection.dart';
import 'package:hi365/pages/login/index.dart';
import 'package:hi365/pages/register/index.dart';
import 'package:hi365/widgets/loading_indicator.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key key}) : super(key: key);

  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _authenticationBloc.add(AppStart());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, currentState) {
        if (currentState is ErrorAuthentication) {
          _authenticationBloc.add(LoggedOut());
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, currentState) {
          if (currentState is Uninitialized) {
            return SplashScreen();
          }

          if (currentState is Unauthenticated) {
            return ChoicesScreen();
          }

          if (currentState is AtLoginPage) {
            return LoginPage();
          }

          if (currentState is AtRegisterPage) {
            return RegisterPage();
          }

          if (currentState is Authenticated) {
            return HomePage();
          }

          if (currentState is AtPhoneLogin) {
            return PhoneSignInSection();
          }

          return LoadingIndicator();
        },
      ),
    );
  }
}
