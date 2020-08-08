class DrugFoodInteractionDescription {
  static final String m0 =
      '無資料，如果您確定用藥紀錄還在就醫日期加給藥天數的期限內，這有可能是您有好一段時間未下載更新健康存摺的資料所導致。';

  static final String m1 = '用藥代碼';

  static final String m2 = '品名';

  static String mes0(String date) =>
      '當天日期(${date ?? "-"})還在就醫日期加給藥天數的期限內之跨科別西醫門診的藥品。';
}
