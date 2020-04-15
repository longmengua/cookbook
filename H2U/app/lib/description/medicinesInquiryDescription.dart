class MedicinesInquiryDescription {

  static final String m0 = '無對應的醫囑(藥品)詳細內容。';

  static final String m1 = '各醫囑(藥品)的詳細內容如下所述，如果沒有，代表無對應的醫囑(藥品)詳細內容。';

  static final List<String> m2 = ['藥品名稱', '適應症', '食品副作用', '仿單', '外盒'];

  static String medicinesDetailTitle(String date, String pharmacy) =>
      '${date ?? "-"}，${pharmacy ?? "-"}的藥品內容';

}
