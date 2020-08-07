import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/account_binding/index.dart';
import 'package:hi365/utils/snackbars.dart';
import 'package:hi365/widgets/base_button.dart';
import 'package:hi365/widgets/bottom_modal_builder.dart';
import 'package:hi365/widgets/text_form_field_builder.dart';

class AccountBindingScreen extends StatefulWidget {
  const AccountBindingScreen({
    Key key,
    @required AccountBindingBloc accountBindingBloc,
  })  : _accountBindingBloc = accountBindingBloc,
        super(key: key);

  final AccountBindingBloc _accountBindingBloc;

  @override
  AccountBindingScreenState createState() =>
      AccountBindingScreenState(_accountBindingBloc);
}

class AccountBindingScreenState extends State<AccountBindingScreen> {
  final AccountBindingBloc _accountBindingBloc;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _accountInfoNameController =
      TextEditingController();

  FocusNode _birthdayOnFocus = FocusNode();

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _birthdayController.text.isNotEmpty &&
      _organizationController.text.isNotEmpty &&
      _accountInfoNameController.text.isNotEmpty;

  bool isSubmitButtonEnabled(AccountBindingState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  AccountBindingScreenState(this._accountBindingBloc);

  @override
  void initState() {
    _usernameController.addListener(_onUsernameChanged);
    _birthdayController.addListener(_onBirthdayChanged);
    _organizationController.addListener(_onOrganizationChanged);
    _accountInfoNameController.addListener(_onAccountInfoNameChanged);
    _birthdayOnFocus.addListener(() {
      if (_birthdayOnFocus.hasFocus) {
        BottomModalBuilder.dateTimePicker(
          context,
          _birthdayController,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBindingBloc, AccountBindingState>(
      bloc: widget._accountBindingBloc,
      listener: _blocListenerHandler,
      child: BlocBuilder<AccountBindingBloc, AccountBindingState>(
        bloc: widget._accountBindingBloc,
        builder: _blocBuilderHandler,
      ),
    );
  }

  void _blocListenerHandler(
    BuildContext context,
    AccountBindingState currentState,
  ) {
    if (currentState.isFailure) {
      String errorMessage = currentState.errorMessage ?? '綁定失敗';
      SnackBarBuilder.showError(context, errorMessage);
    } else if (currentState.isSubmitting) {
      SnackBarBuilder.showLoading(context, '資料正在處理中…');
    } else if (currentState.isSuccess) {
      SnackBarBuilder.showSuccess(context, '綁定成功');
      Navigator.of(context).pop();
    }
  }

  Widget _blocBuilderHandler(
    BuildContext context,
    AccountBindingState currentState,
  ) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 25),
        padding: EdgeInsets.fromLTRB(20, 7, 20, 45),
        alignment: Alignment.center,
        child: Form(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              _showUsernameField(currentState),
              _showBirthdayField(currentState),
              _showOganizationField(currentState),
              _showAccountInfoNameField(currentState),
              _showConfirmButton(currentState),
            ],
          ),
        ));
  }

  Widget _showUsernameField(
    AccountBindingState currentState,
  ) =>
      TextFormFieldBuilder(
        labelText: '姓名',
        hintText: '請輸入姓名',
        controller: _usernameController,
        validateFailureMessage: !currentState.isUsernameValid ? '姓名不可空白' : null,
      );

  Widget _showBirthdayField(
    AccountBindingState currentState,
  ) =>
      TextFormFieldBuilder(
        labelText: '生日',
        hintText: '請輸入生日',
        controller: _birthdayController,
        focusNode: _birthdayOnFocus,
        isReadOnly: true,
        validateFailureMessage: !currentState.isBirthdayValid ? '日期不可空白' : null,
      );

  Widget _showOganizationField(
    AccountBindingState currentState,
  ) =>
      TextFormFieldBuilder(
        labelText: '公司代碼',
        hintText: '請輸入公司代碼',
        controller: _organizationController,
        validateFailureMessage:
            !currentState.isOrganizationValid ? '公司代碼不可空白' : null,
      );

  Widget _showAccountInfoNameField(
    AccountBindingState currentState,
  ) =>
      TextFormFieldBuilder(
        labelText: '工號',
        hintText: '請輸入工號',
        controller: _accountInfoNameController,
        validateFailureMessage:
            !currentState.isAccountInfoNameValid ? '工號不可空白' : null,
      );

  Widget _showConfirmButton(
    AccountBindingState currentState,
  ) =>
      BaseButton(
        title: '確定',
        onPressed:
            isSubmitButtonEnabled(currentState) ? _onFormSubmitted : null,
      );

  void _onUsernameChanged() {
    _accountBindingBloc.add(
      UsernameChanged(username: _usernameController.text),
    );
  }

  void _onBirthdayChanged() {
    _accountBindingBloc.add(
      BirthdayChanged(birthday: _birthdayController.text),
    );
  }

  void _onOrganizationChanged() {
    _accountBindingBloc.add(
      OrganizationChanged(organization: _organizationController.text),
    );
  }

  void _onAccountInfoNameChanged() {
    _accountBindingBloc.add(
      AccountInfoNameChanged(accountInfoName: _accountInfoNameController.text),
    );
  }

  void _onFormSubmitted() {
    _accountBindingBloc.add(
      Submitted(
        username: _usernameController.text,
        birthday: _birthdayController.text,
        organization: _organizationController.text,
        accountInfoName: _accountInfoNameController.text,
      ),
    );
  }
}
