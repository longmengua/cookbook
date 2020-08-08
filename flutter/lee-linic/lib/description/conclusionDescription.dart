import 'package:app/home/homeEvent.dart';
import 'package:app/model/boardItem.dart';

class ConclusionDescription {
  static final String homeIcon = 'assets/images/home.png';
  static final List<BoardItem> list = [
    BoardItem(
      event: HomeEvent.CCIScore,
      imagePath: 'assets/images/icon_dot.png',
      title: 'CCIScore',
      content: '提供查爾森共病指數，讓個案及醫療團隊即時瞭解個人的目前健康狀態。',
    ),
    BoardItem(
      event: HomeEvent.BiochemicalExam,
      imagePath: 'assets/images/icon_dot.png',
      title: '生化檢驗數據',
      content:
          '整理健康存摺跨醫療單位之檢驗數據，以檢驗項目為區隔單位將檢驗結果透過表格呈現，對於數值型檢驗項目增加曲線圖並輔以數值預測運算，讓醫療團隊判定健康狀態及生理功能。',
    ),
    BoardItem(
      event: HomeEvent.DrugInquiry,
      imagePath: 'assets/images/icon_dot.png',
      title: '用藥查詢',
      content:
          '列出健康存摺的用藥記錄，連結衛福部藥品仿單開放資料，讓個案瞭解目前使用藥品之詳細內容，同時提供藥物與食物的副作用之訊息警示的功能。',
    ),
    BoardItem(
      event: HomeEvent.DrugFoodInteraction,
      imagePath: 'assets/images/icon_dot.png',
      title: '藥物與食品交互作用',
      content:
          '此服務係列出當天日期還在就醫日期加給藥天數的期限內之跨科別西醫門診的藥品，找出藥品之間的交互作用，查詢結果請由您的醫療團隊來解讀，李氏健康達人APP對此不承擔任何責任。',
    ),
    BoardItem(
      event: HomeEvent.HealthPromotionService,
      imagePath: 'assets/images/icon_dot.png',
      title: '促進健康服務',
      content:
          '我們列出健康存摺的成人預防保健、癌症篩檢、預防接種、過敏藥物、器捐與安寧緩和與影像病理檢驗報告等等醫療資料，讓您或醫療團隊瞭解目前促進健康的情況。',
    ),
    BoardItem(
      event: HomeEvent.MedicalRecord,
      imagePath: 'assets/images/icon_dot.png',
      title: '就醫看診紀錄',
      content: '提供健康存摺之西醫門診、住院、牙醫門診與中醫門診之主檔就醫看診紀錄。',
    ),
    BoardItem(
      event: HomeEvent.PersonalHealthRiskAssessment,
      imagePath: 'assets/images/icon_dot.png',
      title: '個人健康風險評估',
      content: '透過健康存摺的數據與相關個人資料，提供用戶端關於腦中風或心血管疾病之風險預測評估。',
    ),
  ];
}
