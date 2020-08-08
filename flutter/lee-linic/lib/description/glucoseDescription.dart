class GlucoseDescription {
  static final rule1 =
      '我們目前支援羅氏智航血糖機的藍芽傳輸功能，可以讓您的血糖值傳送到APP。首先︰\n\n1.您必須先從手機的設定功能來配對血糖機。\n2.回到您的智航血糖機，點選[我的資料]，再點選[資料傳輸]，最後停在[無線傳輸]先不點選。\n3.回到本頁畫面點選下方傳輸圖示，再點選2的[無線傳輸]，即可完成傳輸。\n\n點選[檢視]，即可瀏覽血糖機的血糖值。';
  static final rule2 =
      '收縮壓與舒張壓是為了計算您的疾病風險預測值。我們會預先從您的健康存摺成人健檢的收縮壓與舒張壓來自動帶入，如果沒有，請自行輸入。';
  static final glucoseRecordTitle = '血糖紀錄 : ';
  static final previewButton = '檢視';
  static final glucoseMatching = '配對血糖機 : ';
  static final systolic = '收縮壓';
  static final systolicUnit = 'mmHg';
  static final diastolic = '舒張壓';
  static final diastolicUnit = 'mmHg';
  static final button = '存檔';
  static final snackMsg = '資料儲存成功。';
  static final snackMsg1 = '成人健康檢查無血壓紀錄。';

  static final glucoseRecords = [
    '是否為自行量測',
  ];
  static final glucoseRecordsOptions = [
    '否',
    '是',
  ];

  static String glucoseRecordContent({num number}) =>
      number == null ? '沒有血糖紀錄' : '目前有$number筆';
}
