import 'package:app/home/homeEvent.dart';
import 'package:app/model/boardItem.dart';
import 'package:app/model/policy.dart';

class DashBoardDescription {
  static final String appName = '李氏健康達人';
  static final String logoIcon = 'assets/images/lee_clinic_logo.png';
  static final String policyIcon = 'assets/images/app_noexecuse.png';
  static final String homeIcon = 'assets/images/home.png';
  static final String bottomSheet = '在地深耕、視病猶親 專業精進、追求卓越優質服務、永續發展';
  static final policy = Policy(
    title: '李氏健康達人免責聲明',
    content: '''
1、一切用戶端在下載並瀏覽李氏健康達人APP軟體時均被視為已經仔細閱讀本條款並完全同意。凡以任何方式直接、間接使用李氏健康達人APP資料者，均被視為自願接受本APP相關聲明和使用者服務協定的約束。
2、李氏健康達人APP遵守圖片、影音檔及所有發表所用之文字著作權，並盡量使用自創或不需授權的圖片、影音檔及文字。
3、李氏健康達人APP不保證為向用戶提供便利而設置的外部連結的準確性和完整性，同時，對於該外部連結指向的任何網頁上的內容，李氏健康達人APP不承擔任何責任。
4、使用者明確並同意其使用李氏健康達人APP網路服務所存在的風險將完全由其本人承擔;因其使用李氏健康達人APP網路服務而產生的一切後果也由其本人承擔，李氏健康達人APP對此不承擔任何責任。
5、除李氏健康達人APP注明之服務條款外，其它因不當使用本APP而導致的任何意外、疏忽、合約毀壞、誹謗、版權或其他智慧財產權侵犯及其所造成的任何損失，李氏健康達人APP概不負責，亦不承擔任何法律責任。
6、對於因不可抗力或因駭客攻擊、通訊線路中斷等李氏健康達人APP不能控制的原因造成的網路服務中斷或其他缺陷，導致用戶不能正常使用李氏健康達人APP，李氏健康達人APP不承擔任何責任，但將盡力減少因此給用戶造成的損失或影響。
7、本聲明未涉及的問題請參見國家有關法律法規，當本聲明與國家有關法律法規衝突時，以國家法律法規為准。
8、本APP相關聲明版權及其修改權、更新權和最終解釋權均屬李氏健康達人APP所有。
    ''',
  );

  static final List<String> options = ['同意','不同意'];

  static String mes0(String version) => '版本編號(${version ?? "-"})';

  static final List<BoardItem> list = [
    BoardItem(
      event: HomeEvent.diabetes,
      imagePath: 'assets/images/icon_promotehealth_info.png',
      title: '糖尿病促進健康訊息',
      content: '節錄最新李氏聯合診所季刊文章，包括醫學新知、自我管理教育與營養健康的飲食等主題，讓大眾藉由文章的內容瞭解更多糖尿病相關知識。',
    ),
    BoardItem(
      event: HomeEvent.medical,
      imagePath: 'assets/images/icon_medical_info.png',
      title: '專業人員醫療健康訊息',
      content: '與「李氏聯合診所  李洮俊糖尿病中心」的粉絲專頁訊息同步，動態更新並掌握專業人員糖尿病健康訊息。',
    ),
    BoardItem(
      event: HomeEvent.healthBank,
      imagePath: 'assets/images/icon_myhealthbank.png',
      title: '健康存摺',
      content: '藉由健保署釋出的「健康存摺SDK」，讓我們的APP透過該SDK取得用戶端健康存摺的數據資料，做為我們APP的資料來源。',
    ),
    BoardItem(
      event: HomeEvent.glucose,
      imagePath: 'assets/images/icon_bp_bs_record.png',
      title: '血壓、血糖記錄',
      content:
          '用戶端的血糖、血壓資料。我們可以連接羅氏智航血糖機，下載血糖記錄到裝置中；也可以取得健康存摺的成人健檢血壓資料，做為我們APP的資料來源。',
    ),
    BoardItem(
      event: HomeEvent.config,
      imagePath: 'assets/images/icon_personal_info.png',
      title: '個人資料設定',
      content:
          '提供家族史、個人生活型態(抽菸、運動史)、疾病史等等的資料紀錄，讓我們瞭解更多，透過個人健康總結的功能來計算疾病風險罹病的機率。',
    ),
    BoardItem(
      event: HomeEvent.conclusion,
      imagePath: 'assets/images/icon_phr.png',
      title: '個人健康總結',
      content:
          '以PHR(Personal Health Record)為設計概念，結合上述包含健康存摺、血糖血壓與個人資訊，提供CCI Score、生化檢驗數據、用藥查詢、促進健康服務與個人健康風險評估等服務，讓用戶端與醫療端作為SDM(醫病共享決策)參考依據。',
    ),
  ];
}
