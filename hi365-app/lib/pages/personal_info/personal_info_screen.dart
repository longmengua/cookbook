import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/personal_info/index.dart';
import 'package:hi365/utils/snackbars.dart';
import 'package:hi365/widgets/base_button.dart';
import 'package:hi365/widgets/bottom_modal_builder.dart';
import 'package:hi365/widgets/text_form_field_builder.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({
    Key key,
    @required PersonalInfoBloc personalInfoBloc,
  })  : _personalInfoBloc = personalInfoBloc,
        super(key: key);

  final PersonalInfoBloc _personalInfoBloc;

  @override
  PersonalInfoScreenState createState() =>
      PersonalInfoScreenState(_personalInfoBloc);
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final PersonalInfoBloc _personalInfoBloc;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  final Map<String, String> _gender = {
    '男': 'M',
    '女': 'F',
  };

  bool get isPopulated =>
      _genderController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _birthdayController.text.isNotEmpty &&
      _idNumberController.text.isNotEmpty;

  bool isSubmitButtonEnabled(PersonalInfoState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  FocusNode _birthdayOnFocus = FocusNode();
  FocusNode _genderOnFocus = FocusNode();

  PersonalInfoScreenState(this._personalInfoBloc);

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onUsernameChanged);
    _genderController.addListener(_onGenderChanged);
    _idNumberController.addListener(_onIDNumberChanged);
    _birthdayController.addListener(_onBirthdayChanged);
    _birthdayOnFocus.addListener(() {
      if (_birthdayOnFocus.hasFocus) {
        BottomModalBuilder.dateTimePicker(
          context,
          _birthdayController,
        );
      }
    });
    _genderOnFocus.addListener(() {
      if (_genderOnFocus.hasFocus) {
        BottomModalBuilder.items(
          context,
          _genderController,
          _gender.keys.toList(),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoBloc, PersonalInfoState>(
      bloc: widget._personalInfoBloc,
      listener: _blocListenerHandler,
      child: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        bloc: widget._personalInfoBloc,
        builder: _blocBuilderHandler,
      ),
    );
  }

  void _blocListenerHandler(
    BuildContext context,
    PersonalInfoState currentState,
  ) {
    if (currentState.isFailure) {
      String errorMessage = currentState.errorMessage ?? '儲存失敗';
      SnackBarBuilder.showError(context, errorMessage);
    } else if (currentState.isSubmitting) {
      SnackBarBuilder.showLoading(context, '資料正在處理中');
    } else if (currentState.isSuccess) {
      SnackBarBuilder.showSuccess(context, '儲存成功');
      Navigator.of(context).pop();
    }
  }

  Widget _blocBuilderHandler(
    BuildContext context,
    PersonalInfoState currentState,
  ) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 7, 20, 45),
        alignment: Alignment.center,
        child: Form(
          child: ListView(
            children: <Widget>[
              _showWarringMessage(),
              _showUsernameField(currentState),
              _showGenderField(currentState),
              _showidNumberField(currentState),
              _showBirthdayField(currentState),
              _showConfirmButton(currentState),
            ],
          ),
        ));
  }

  Widget _showWarringMessage() {
    return Container(
      margin: EdgeInsets.fromLTRB(70, 25, 70, 25),
      child: Text(
        '嗨！透過簡單的設定，\n開始專屬於您的健康生活。',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, color: Color.fromRGBO(0x11, 0x11, 0x11, .54)),
      ),
    );
  }

  Widget _showUsernameField(PersonalInfoState currentState) {
    return TextFormFieldBuilder(
      labelText: '姓名',
      hintText: '請輸入您的姓名',
      controller: _usernameController,
      validateFailureMessage: !currentState.isUsernameValid ? '請輸入姓名' : null,
    );
  }

  Widget _showGenderField(PersonalInfoState currentState) {
    return TextFormFieldBuilder(
      labelText: '性別',
      hintText: '請選擇您的性別',
      isReadOnly: true,
      controller: _genderController,
      focusNode: _genderOnFocus,
      validateFailureMessage: !currentState.isGenderValid ? '請選擇性別' : null,
    );
  }

  Widget _showidNumberField(PersonalInfoState currentState) {
    return TextFormFieldBuilder(
      labelText: '身分證字號',
      hintText: '請輸入身分證字號',
      controller: _idNumberController,
      validateFailureMessage: !currentState.isIDNumberValid ? '請輸入身份證字號' : null,
    );
  }

  Widget _showBirthdayField(PersonalInfoState currentState) {
    return TextFormFieldBuilder(
      labelText: '生日',
      hintText: '請輸入生日',
      controller: _birthdayController,
      focusNode: _birthdayOnFocus,
      isReadOnly: true,
      validateFailureMessage: !currentState.isBirthdayValid ? '請輸入生日' : null,
    );
  }

  Widget _showConfirmButton(PersonalInfoState currentState) {
    return BaseButton(
      title: '確定',
      onPressed: isSubmitButtonEnabled(currentState) ? _onFormSubmitted : null,
    );
  }

  void _onUsernameChanged() {
    _personalInfoBloc.add(
      UsernameChanged(username: _usernameController.text),
    );
  }

  void _onGenderChanged() {
    _personalInfoBloc.add(
      GenderChanged(gender: _genderController.text),
    );
  }

  void _onIDNumberChanged() {
    _personalInfoBloc.add(
      IDNumberChanged(idNumber: _idNumberController.text),
    );
  }

  void _onBirthdayChanged() {
    _personalInfoBloc.add(
      BirthdayChanged(birthday: _birthdayController.text),
    );
  }

  void _onFormSubmitted() {
    PersonalInfo personalInfo = PersonalInfo();
    personalInfo.gender = _gender[_genderController.text];
    personalInfo.govId = _idNumberController.text;
    personalInfo.name = _usernameController.text;

    String birthday = _birthdayController.text.split('/').join('-');
    personalInfo.birthday = DateTime.parse(birthday).millisecondsSinceEpoch;

    _personalInfoBloc.add(
      Submitted(
        personalInfo: personalInfo,
      ),
    );
  }
}
