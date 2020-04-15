class KeyReportDTO {
  String _definition;
  String _effect;
  String _keyCode;
  String _severity;
  String _description;
  String _ruleId;
  String _ruleName;
  String _title;
  String _ruleDescription;
  String _sugMsg;
  List _listKeyReportCheckResultVal;

  KeyReportDTO.fromJson(Map<String, dynamic> json) {
    _definition = json['definition'];
    _effect = json['effect'];
    _keyCode = json['keyCode'];
    _severity = json['severity'];
    _description = json['description'];
    _ruleId = json['ruleId'];
  }

  KeyReportDTO(
      this._listKeyReportCheckResultVal,
      this._definition,
      this._effect,
      this._keyCode,
      this._severity,
      this._description,
      this._ruleId);

  KeyReportDTO.empty();

  List get listKeyReportCheckResultVal => _listKeyReportCheckResultVal;

  set listKeyReportCheckResultVal(List value) {
    _listKeyReportCheckResultVal = value;
  }

  String get definition => _definition;

  set definition(String value) {
    _definition = value;
  }

  String get effect => _effect;

  set effect(String value) {
    _effect = value;
  }

  String get keyCode => _keyCode;

  set keyCode(String value) {
    _keyCode = value;
  }

  String get severity => _severity;

  set severity(String value) {
    _severity = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get ruleId => _ruleId;

  set ruleId(String value) {
    _ruleId = value;
  }

  String get ruleName => _ruleName;

  set ruleName(String value) {
    _ruleName = value;
  }

  String get ruleDescription => _ruleDescription;

  set ruleDescription(String value) {
    _ruleDescription = value;
  }

  String get sugMsg => _sugMsg;

  set sugMsg(String value) {
    _sugMsg = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }


}
