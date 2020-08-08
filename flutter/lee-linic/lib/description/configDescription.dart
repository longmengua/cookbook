class ConfigDescription {
  static final rule1 = '''
請確實填寫下列欄位的資料，這樣能讓我們瞭解更多，進而透過個人健康總結的功能來計算疾病風險罹病的機率。\n\n注意︰糖尿病罹病期填0代表沒有罹患糖尿病
  ''';
  static final confirmButton = '存檔';
  static final ageTitle = '年齡';
  static final ageUnit = '歲';
  static final diabetesPeriod = '糖尿病罹病期';
  static final diabetesUnit = '年';
  static final gender = ['性別'];
  static final genderOptions = ['女','男'];
  static final healthRecords = [
    '是否有抽菸習慣',
    '是否有糖尿病家族史',
    '是否有心率異常',
    '是否有高血壓藥物',
  ];
  static final healthRecordsOptions = [
    '無',
    '有',
  ];

  static final snackMsg = '資料儲存成功。';
}
