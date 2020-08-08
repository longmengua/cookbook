class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
//    r'.*',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
//    r'.*',
  );

  static final RegExp _idNumberRegExp = RegExp(
    r'^[A-Za-z]{1}\d{9}$',
  );

  static isValidEmail(String email) => _emailRegExp.hasMatch(email);

  static isValidPassword(String password) => _passwordRegExp.hasMatch(password);

  static isValidIDNumber(String idNumber) => _idNumberRegExp.hasMatch(idNumber);
}
