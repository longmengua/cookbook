import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hi365/pages/checkup/checkup_master/bloc/bloc.dart';
import 'package:hi365/utils/snackbars.dart';
import 'package:hi365/widgets/base_button.dart';
import 'package:hi365/widgets/bottom_modal_builder.dart';
import 'package:hi365/widgets/text_form_field_builder.dart';

import '../checkup_model.dart';
import 'bloc/bloc.dart';

class CheckupDownloadScreen extends StatefulWidget {
  const CheckupDownloadScreen({
    Key key,
    @required CheckupDownloadBloc checkupDownloadBloc,
  })  : _checkupDownloadBloc = checkupDownloadBloc,
        super(key: key);

  final CheckupDownloadBloc _checkupDownloadBloc;

  @override
  CheckupDownloadScreenState createState() =>
      CheckupDownloadScreenState(_checkupDownloadBloc);
}

class CheckupDownloadScreenState extends State<CheckupDownloadScreen> {
  final CheckupDownloadBloc _checkupDownloadBloc;
  final TextEditingController _institutionController = TextEditingController();

  List<CheckupInstitution> _institutionList = [];

  FocusNode _institutionOnFocus = FocusNode();

  bool get isPopulated => _institutionController.text.isNotEmpty;

  bool isSubmitButtonEnabled(CheckupDownloadState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  CheckupDownloadScreenState(this._checkupDownloadBloc);

  @override
  void initState() {
    super.initState();
    _checkupDownloadBloc.add(GetInstituionList());
    _institutionController.addListener(_onInstitutionChanged);
    _institutionOnFocus.addListener(() {
      if (_institutionList.length > 0 && _institutionOnFocus.hasFocus) {
        BottomModalBuilder.items(
          context,
          _institutionController,
          _institutionList.map((i) => i.name).toList(),
        );
      }
      _institutionOnFocus.unfocus();
    });
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _institutionOnFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckupDownloadBloc, CheckupDownloadState>(
      bloc: widget._checkupDownloadBloc,
      listener: (context, state) {
        if (state.isEmpty) {
          _clearInputs();
        } else if (state.isFailure) {
          SnackBarBuilder.showError(context, '下載失敗');
        } else if (state.isSubmitting) {
          SnackBarBuilder.showLoading(context, '正在下載健檢資料…');
        } else if (state.isSuccess) {
          // Refresh CheckupMaster data
          BlocProvider.of<CheckupMasterBloc>(context).add(LoadCheckupMaster());
          Navigator.of(context).pop();
        } else if (state.institutionList.isNotEmpty) {
          _institutionList = state.institutionList;
        }
      },
      child: BlocBuilder<CheckupDownloadBloc, CheckupDownloadState>(
          bloc: widget._checkupDownloadBloc,
          builder: (BuildContext context, CheckupDownloadState currentState) {
            return Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 25),
                padding: EdgeInsets.fromLTRB(20, 7, 20, 45),
                alignment: Alignment.center,
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      _showInstitutionField(currentState),
                      _showConfirmButton(currentState),
                    ],
                  ),
                ));
          }),
    );
  }

  /// Institution text field
  Widget _showInstitutionField(CheckupDownloadState state) {
    return TextFormFieldBuilder(
      labelText: '健檢機構',
      hintText: '請選擇',
      controller: _institutionController,
      focusNode: _institutionOnFocus,
      isReadOnly: true,
      validateFailureMessage: !state.isInsitutionValid ? '請選擇機構' : null,
    );
  }

  Widget _showConfirmButton(CheckupDownloadState state) {
    return BaseButton(
      title: '確定',
      onPressed: isSubmitButtonEnabled(state)
          ? _showDataAccessDeclarationDialog
          : null,
    );
  }

  Future<void> _showDataAccessDeclarationDialog() async {
//    return await _showDeclarationDialog(
    return await _showDialog(
      '授權取得健檢機構之健檢報告',
      _showDataSaveDeclarationDialog,
    );
  }

  Future<void> _showDataSaveDeclarationDialog() async {
//    return await _showDeclarationDialog(
    return await _showDialog(
      '授權同意健檢報告儲存分析資料使用',
      _onFormSubmitted,
    );
  }

  Future<void> _showDeclarationDialog(
    String content,
    Function callback,
  ) async {
    return await showCupertinoDialog(
      builder: (context) => CupertinoAlertDialog(
        title: Text('聲明事項'),
        content: Text(content ?? ' '),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: .1),
                right: BorderSide(width: .1),
              ),
            ),
            child: CupertinoActionSheetAction(
              child: Center(child: Text('取消')),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: .1),
              ),
            ),
            child: CupertinoActionSheetAction(
              child: Text('同意'),
              onPressed: () {
                // Close confirm dialog
                Navigator.of(context).pop();
                callback();
              },
            ),
          ),
        ],
      ),
      context: context,
    );
  }

  void _clearInputs() {
    setState(() {
      _institutionController.text = '';
    });
  }

  void _onInstitutionChanged() {
    _checkupDownloadBloc.add(
      InstitutionChanged(institution: _institutionController.text),
    );
  }

  void _onFormSubmitted() {
    CheckupInstitution hospital = _institutionList
        .where((i) => i.name == _institutionController.text)
        .toList()[0];
    _checkupDownloadBloc.add(
      Submitted(
        hospitalId: hospital.hospitalId,
      ),
    );
  }

  Future _showDialog(
    String content,
    Function callback,
  ) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "聲明事項",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Text(
                  content ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, height: 2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.3)),
                          right:
                              BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      child: GestureDetector(
                        child: new Text(
                          "取消",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff396C9B)),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 11),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      child: GestureDetector(
                        child: new Text(
                          "同意",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff396C9B)),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          callback();
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
