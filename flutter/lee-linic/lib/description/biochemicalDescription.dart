class BiochemicalDescription {
  static final String nonData = '無資料';
  static final List<String> tableHeader = [
    '醫療機構',
    '檢驗名',
    '檢驗日期',
    '結果值',
  ];

  static final String m0 = '運算服務';
  static final String m1 = '關閉';

  static String p0(String name, String result) => '$name 的數值呈現 $result 的趨勢';
}
