import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:app/config/appConfig.dart';
import 'package:app/widget/util/aesCbcPkcs5Padding.dart';
import 'package:app/widget/util/dioFactory.dart';
import 'package:app/config/requestURLInfo.dart';
import 'package:app/description/configDescription.dart';
import 'package:app/model/RiskAssessment.dart';
import 'package:app/model/healthInfo.dart';
import 'package:app/model/medicalItem.dart';
import 'package:app/widget/util/dateTimeComputation.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import 'homeEvent.dart';
import 'homeState.dart';

///@author Waltor
///@Note all business should be dealing with here.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  BuildContext buildContext;
  Dio dio = DioFactory().getDio;
  Dio formDio = DioFactory().getFormDio;
  num mode = 0; // 0:health bank api, 1:local, 2:mock server.//
  String url; //For storing mock server url;
  File file; //判斷檔案是否存在。
  dynamic data; //暫存資料用

  Map userJson; //使用者資料。存在本地端。
  Bdata bdata; //健康存摺資料
  bool isUpdated = false; //健康存摺是否已更新，default is false, 當開啟健康存摺，則給予true。

  int cciScore; //cciScore 為 查爾森共病指數(Charlson Comorbidity Index,CCI)。
  Map<String, String> iCD10; //診斷碼
  Map<String, List<R7>> examMap; //生化檢驗
  Map<String, List<R1>> drugInquiry; //用藥查詢
  Set<String> drugInquirySet; //用藥查詢，記錄所有藥品的代碼
  Set<R11array> drugFoodInteraction; //藥物與食品交互作用
  RiskAssessment riskAssessment; //個人健康風險評估

  HomeBloc(this.buildContext);

  @override
  HomeState get initialState => HomeState.splash;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    yield HomeState.loading;
    try {
      switch (event) {
        case HomeEvent.splash:
          break;
        case HomeEvent.dashboard:
          yield await readUserInfo() ? HomeState.dashboard : HomeState.error;
          break;
        case HomeEvent.diabetes:
          //糖尿病促進健康訊息。
          final result = await dio.get(RequestURLInfo.diabetesUrl);
          data = result.data;
          yield data != null ? HomeState.diabetes : HomeState.networkError;
          break;
        case HomeEvent.medical:
          //專業人員醫療健康訊息
          final result = await dio.get(RequestURLInfo.medicalUrl).then((v) {
            return jsonDecode(v.data);
          }).then((v) {
            return MedicalItem.fromJson(v);
          });
          data = result.medicalInfo;
          yield data != null ? HomeState.medical : HomeState.networkError;
          break;
        case HomeEvent.healthBank:
          //健康康存摺
          yield HomeState.healthBank;
          break;
        case HomeEvent.glucose:
          //血壓、血糖紀錄
          //讀取健康存摺後再讀取血壓紀錄。
          await getHealthBankJson() && getBloodPressureInfo();
          yield HomeState.glucose;
          break;
        case HomeEvent.config:
          //個人資料設定
          yield HomeState.config;
          break;
        case HomeEvent.conclusion:
          //個人健康總結
          //讀取健康存摺
          yield await getHealthBankJson()
              ? HomeState.conclusion
              : HomeState.noHealthBankFileError;
          break;
        case HomeEvent.CCIScore:
          //CCIScore
          yield await cciScoreAnalyze() ? HomeState.CCIScore : HomeState.error;
          break;
        case HomeEvent.BiochemicalExam:
          //生化檢驗數據
          yield await biochemicalExamList()
              ? HomeState.BiochemicalExam
              : HomeState.error;
          break;
        case HomeEvent.DrugInquiry:
          //用藥查詢
          yield await drugInquiryList()
              ? HomeState.DrugInquiry
              : HomeState.error;
          break;
        case HomeEvent.DrugFoodInteraction:
          //藥物與食品交互作用
          yield await getDrugFoodInteraction()
              ? HomeState.DrugFoodInteraction
              : HomeState.error;
          break;
        case HomeEvent.HealthPromotionService:
          //促進健康服務
          yield HomeState.HealthPromotionService;
          break;
        case HomeEvent.MedicalRecord:
          //就醫看診紀錄
          yield HomeState.MedicalRecord;
          break;
        case HomeEvent.PersonalHealthRiskAssessment:
          //個人健康風險評估
          yield riskAssessmentCalculation()
              ? HomeState.PersonalHealthRiskAssessment
              : HomeState.error;
          break;
        case HomeEvent.networkError:
          yield HomeState.networkError;
          break;
        case HomeEvent.noHealthBankFileError:
          yield HomeState.noHealthBankFileError;
          break;
        case HomeEvent.error:
        default:
          yield HomeState.error;
          break;
      }
    } catch (e) {
      print(e);
      yield HomeState.error;
    }
  }

  get localFile async {
    final directory = await getApplicationDocumentsDirectory();
    this.file = File('${directory.path}/userInfo.txt');
    if (this.file.existsSync()) return;
    String date = DateTime.now().toString().substring(0, 10);
    await this.file.writeAsString('{"startDate":"$date"}');
  }

  ///寫入個人資料
  Future<bool> writeUserInfo(String json) async {
    try {
      if (this.file == null) await localFile;
      if (userJson != null && json != null) {
        userJson.addAll(jsonDecode(json));
      }
//      print(jsonEncode(userJson));
      await this.file.writeAsString(jsonEncode(userJson));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///@see https://flutter.dev/docs/cookbook/persistence/reading-writing-files
  Future<bool> readUserInfo() async {
    if (userJson != null) return true;
    try {
      if (this.file == null) await localFile;
      String contents = await file.readAsString();
      userJson = jsonDecode(contents);
      //url is for mock server testing.
      url = userJson['url'] == null
          ? 'https://021f9db2.ngrok.io'
          : userJson['url'];
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  policy() {
    writeUserInfo('{"policy":true}');
  }

  userInfo(String age, String period, String gender, String health) {
    String json = '{'
        '"age":"${age ?? ''}",'
        '"diabetesDuration":"${period ?? ''}",'
        '"gender":${gender ?? ''},'
        '"health":${health ?? ''}'
        '}';
    writeUserInfo(json);
  }

  void bloodPressureInfo(String systolicBloodPressure,
      String diastolicBloodPressure, String isManual) async {
    String json = '{'
        '"systolicBloodPressure":"$systolicBloodPressure",'
        '"diastolicBloodPressure":"$diastolicBloodPressure",'
        '"isManual":$isManual' //1：是，0：否
        '}';
    writeUserInfo(json);
  }

  void settingMockServerURL(String url) {
    print(url);
    String json = '{"url":"$url"}';
    this.url = url;
    writeUserInfo(json);
  }

  ///讀取健康存摺。
  Future<bool> getHealthBankJson() async {
    try {
      //避免重複讀取健康存摺，如果以讀取過，則離開。//當健康存摺更新後，
      if (bdata != null && !isUpdated) return true;
      switch (mode) {
        case 0: //real health bank data binding test.
          break;
        case 1: //local testing
          print('Start to unzip file');
          String jsonString = await DefaultAssetBundle.of(buildContext)
              .loadString("assets/test2.json")
              .then((v) => v);
          print('Start to parse json');
          bdata =
              HealthInfo.fromJson(jsonDecode(jsonString)).myhealthbank.bdata;
          break;
        case 2: //mock server testing
        default:
          if (url == null)
            throw Exception('The url property sholud not be null in homebloc.');
          String jsonString = await dio.get(url).then((v) => v?.toString());
          if (jsonString == null)
            throw Exception('Could not get data from this url.');
          bdata =
              HealthInfo.fromJson(jsonDecode(jsonString)).myhealthbank.bdata;
          break;
      }
      print('Getting health bank data is done');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///cciScore 為 查爾森共病指數(Charlson Comorbidity Index,CCI)。
  Future<bool> cciScoreAnalyze() async {
    //診斷碼
    iCD10 = Map<String, String>();
    //計算cci score
    cciScore = 0;
    if (bdata == null) {
      print('生化檢驗資料解析錯誤。');
      return false;
    }
    try {
      bdata?.r1?.forEach((r1) => iCD10.putIfAbsent(r1.r18,
          () => '${r1?.r19?.trim() ?? '-'} (${r1?.r15?.trim() ?? '-'})'));
      bdata?.r2?.forEach((r2) => iCD10.putIfAbsent(r2.r210,
          () => '${r2?.r211?.trim() ?? '-'} (${r2?.r25?.trim() ?? '-'})'));
      if ([
        'I21',
        'I22',
        'I252',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'I099',
        'I110',
        'I130',
        'I132',
        'I255',
        'I420',
        'I425',
        'I426',
        'I427',
        'I428',
        'I429',
        'I43',
        'I50',
        'P290'
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'I70',
        'I71',
        'I731',
        'I738',
        'I739',
        'I771',
        'I790',
        'I792',
        'K551',
        'K558',
        'K559',
        'Z958',
        'Z959',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'G45',
        'G46',
        'H340',
        'I60',
        'I61',
        'I62',
        'I63',
        'I64',
        'I65',
        'I66',
        'I67',
        'I68',
        'I69'
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if (['F00', 'F01', 'F02', 'F03', 'F051', 'G30', 'G311']
          .fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'I278',
        'I279',
        'J40',
        'J41',
        'J42',
        'J43',
        'J44',
        'J45',
        'J46',
        'J47',
        'J60',
        'J61',
        'J62',
        'J63',
        'J64',
        'J65',
        'J66',
        'J67',
        'J684',
        'J701',
        'J703'
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'M05',
        'M06',
        'M315',
        'M32',
        'M33',
        'M34',
        'M351',
        'M353',
        'M360',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'K25',
        'K26',
        'K27',
        'K28',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'B18',
        'K700',
        'K701',
        'K702',
        'K703',
        'K709',
        'K713',
        'K714',
        'K715',
        'K717',
        'K73',
        'K74',
        'K760',
        'K762',
        'K763',
        'K764',
        'K768',
        'K769',
        'Z944',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'E100',
        'E101',
        'E106',
        'E108',
        'E109',
        'E110',
        'E111',
        'E116',
        'E118',
        'E119',
        'E120',
        'E121',
        'E126',
        'E128',
        'E129',
        'E130',
        'E131',
        'E136',
        'E138',
        'E139',
        'E140',
        'E141',
        'E146',
        'E148',
        'E149',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore++;
      if ([
        'E102',
        'E103',
        'E104',
        'E105',
        'E107',
        'E112',
        'E113',
        'E114',
        'E115',
        'E117',
        'E122',
        'E123',
        'E124',
        'E125',
        'E143',
        'E144',
        'E145',
        'E147',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore += 2;
      if ([
        'G041',
        'G114',
        'G801',
        'G802',
        'G81',
        'G82',
        'G830',
        'G831',
        'G832',
        'G833',
        'G834',
        'G839',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore += 2;
      if ([
        'I120',
        'I131',
        'N032',
        'N033',
        'N034',
        'N035',
        'N036',
        'N037',
        'N052',
        'N053',
        'N054',
        'N055',
        'N056',
        'N18',
        'N19',
        'N250',
        'Z490',
        'Z491',
        'Z492',
        'Z940',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore += 2;
      if ([
        'C00',
        'C01',
        'C02',
        'C03',
        'C04',
        'C05',
        'C06',
        'C07',
        'C08',
        'C09',
        'C10',
        'C11',
        'C12',
        'C13',
        'C14',
        'C15',
        'C16',
        'C17',
        'C18',
        'C19',
        'C20',
        'C21',
        'C22',
        'C23',
        'C24',
        'C25',
        'C26',
        'C30',
        'C31',
        'C32',
        'C33',
        'C34',
        'C37',
        'C38',
        'C39',
        'C40',
        'C41',
        'C43',
        'C45',
        'C46',
        'C47',
        'C48',
        'C49',
        'C50',
        'C51',
        'C52',
        'C53',
        'C54',
        'C55',
        'C56',
        'C57',
        'C58',
        'C60',
        'C61',
        'C62',
        'C63',
        'C64',
        'C65',
        'C66',
        'C67',
        'C68',
        'C69',
        'C70',
        'C71',
        'C72',
        'C73',
        'C74',
        'C75',
        'C76',
        'C81',
        'C82',
        'C83',
        'C84',
        'C85',
        'C88',
        'C90',
        'C91',
        'C92',
        'C93',
        'C94',
        'C95',
        'C96',
        'C97',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore += 2;
      if ([
        'I850',
        'I859',
        'I864',
        'I982',
        'K704',
        'K711',
        'K721',
        'K729',
        'K765',
        'K766',
        'K767',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore += 3;
      if ([
        'C77',
        'C78',
        'C79',
        'C80',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore += 6;
      if ([
        'B20',
        'B21',
        'B22',
        'B24',
      ].fold(false, (prev, element) => prev || ifNotEmpty(iCD10, element)))
        cciScore += 6;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool ifNotEmpty(Map<String, String> iCD10, String key) {
    return iCD10[key] != null && iCD10[key].length > 0;
  }

  ///生化檢查數據
  Future<bool> biochemicalExamList() async {
    if (bdata == null) return false;
    try {
      examMap = {};
      //無資料
      if (bdata.r7 == null ||
          (bdata.r7.length == 1 && bdata.r7.first.r7 != null)) {
        examMap = null;
      } else {
        bdata.r7.sort((a, b) {
          return a.r76.compareTo(b.r76);
        }); //先依照時間排序。
        bdata.r7.forEach((v) {
          String r78 = v?.r78?.trim();
          String r79 = v?.r79 == '' ? '無醫囑名稱' : v?.r79?.trim();
          String key = '$r79 || $r78';
          //醫囑代碼做區分
          examMap.containsKey(key)
              ? examMap[key].add(v)
              : examMap.putIfAbsent(key, () => [v]);
        });
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///生化檢查數據，預測曲線
  Future biochemicalExamPredicate(String selectedR7String) async {
    List<String> r711s =
        examMap[selectedR7String].map((r7) => r7.r711).toList();
    String r711String = r711s.toString();
    r711String = r711String.substring(
        1, r711String.length - 1); //eliminate open/close brackets.
    String encryption = await AesCbcPKCS5Padding.encryption(
        data: r711String, key: AppConfig.password);
    Map request = {}..putIfAbsent("p", () => encryption);
    final result =
        await formDio.post(RequestURLInfo.apiValPredict, data: request);
    return result;
  }

  ///用藥查詢
  Future<bool> drugInquiryList() async {
    try {
      if (bdata == null) return false;
      drugInquirySet = Set();
      drugInquiry = {};
      //依照時間先排序。
      bdata.r1.sort((a, b) {
        String date1 = a.r15.length > 0 ? a.r15 : a.r16;
        String date2 = b.r15.length > 0 ? b.r15 : b.r16;
        return date2.compareTo(date1); //sort by DESC.
      });
      bdata.r1.forEach((r1) {
        R1 tmp = r1;
        //去除非藥品的項目 //長度為10即是藥品
        tmp.r11array =
            r1.r11array.where((v) => v.r111.trim().length == 10).toList();
        //若無藥品，直接不做任何處理。
        if (tmp.r11array.length <= 0) return;
        //醫院名稱當ＫＥＹ值
        String key = '${r1.r14 ?? "-"}';
        drugInquiry.containsKey(key)
            ? drugInquiry[key].add(tmp)
            : drugInquiry.putIfAbsent(key, () => [tmp]);
        //儲存藥品到drugInquirySet
        drugInquirySet.addAll(tmp.r11array.map((r11array) => r11array.r111));
      });
//    print(drugInquiry);
      final result = await apiDrugInquiry();
      data = result?.data ?? null;
      print(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  ///用藥查詢api
  Future apiDrugInquiry() async {
    String parameters = drugInquirySet.toString();
    parameters = parameters.toString().substring(1, parameters.length - 1);
    print(parameters);
    String encryption = await AesCbcPKCS5Padding.encryption(
        data: parameters.toString(), key: AppConfig.password);
    Map request = {}..putIfAbsent("p", () => encryption);
    return formDio.post(
      RequestURLInfo.apiMedicalGet,
      data: request,
    );
  }

  ///藥物與食品交互作用
  Future<bool> getDrugFoodInteraction() async {
    drugFoodInteraction = Set();
    try {
      bdata.r1.forEach((R1 r1) {
        String dateString = r1.r15.length > 0 ? r1.r15 : r1.r16;
        DateTime today =
            DateTime.now().subtract(Duration(days: 1)); //get yesterday.
        DateTime medicineStartedDay = DateTime.tryParse(dateString);
        r1.r11array.forEach((r11array) {
          //r111長度不為10的，都屬非藥品的。
          if (r11array.r111.trim().length != 10) return;
          DateTime medicineEndDay = medicineStartedDay
              .add(Duration(days: num.tryParse(r11array?.r114 ?? 0)));
          //判斷是否還在藥品使用區間
          if (DateTimeComputation.between(
            today,
            startDate: medicineStartedDay,
            endDate: medicineEndDay,
          )) {
            //用ＳＥＴ，避免重複的藥品加入。（記得要覆寫R11array的『 == 』operator)
            drugFoodInteraction.add(r11array..startedDay = medicineStartedDay);
          }
        });
      });
      final result = await apiDrugFoodInteraction();
      data = result?.toString();
//      print(data);
    } catch (e) {
      print(e);
    }
    return true;
  }

  ///藥物與食品交互作用api
  Future apiDrugFoodInteraction() async {
    StringBuffer parameters = StringBuffer();
    drugFoodInteraction.forEach((v) => parameters..write("${v.r111},"));
    parameters.toString().substring(1, parameters.length - 1);
    print(parameters);
    String encryption = await AesCbcPKCS5Padding.encryption(
        data: parameters.toString(), key: AppConfig.password);
    Map request = {}..putIfAbsent("p", () => encryption);
    return formDio.post(
      RequestURLInfo.apiDrugFoodIntGet,
      data: request,
    );
  }

  ///個人健康評估
  ///共四部分，取得個人資料，取得健康存摺資料，取得血壓、血糖機相關資料，分析計算。
  bool riskAssessmentCalculation() {
    try {
      riskAssessment = RiskAssessment();
      getPersonalInfo();
      getHealthBankInfo();
      getBps();
      getAnalyzation();
      print(riskAssessment);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///個人資料
  ///@refer [ConfigDescription.healthRecords]
  ///@refer [HomeBloc.userInfo]
  ///@refer [HomeBloc.checkMapValue]
  getPersonalInfo() {
    riskAssessment.gender =
        userJson['gender'] == null ? null : userJson['gender'][0]; //性別
    riskAssessment.age = checkMapValue(userJson['age']); //年齡
    riskAssessment.smoke = checkMapValue(
        userJson['health'] == null ? null : userJson['health'][0]); //抽煙
    riskAssessment.familyHistoryOfDiabetes = checkMapValue(
        userJson['health'] == null ? null : userJson['health'][1]); //家族糖尿病病史
    riskAssessment.heartRate = checkMapValue(
        userJson['health'] == null ? null : userJson['health'][2]); //心率
    riskAssessment.diabetesDuration =
        checkMapValue(userJson['diabetesDuration']); //糖尿病病期
    //糖尿病病期為小於0或null時，代表無糖尿病，反之則有。
    riskAssessment.diabetes = riskAssessment.diabetesDuration == null ||
            riskAssessment.diabetesDuration <= 0
        ? 0
        : 1;
  }

  ///無資料，則默認數值為-1。
  num checkMapValue(String value) {
    return value == null ? -1 : num.parse(value);
  }

  ///健康存摺
  getHealthBankInfo() {
    if (bdata.r10.length <= 0) return;
    //取得最後的成健資料
    //成人健康檢查 r10
    bdata.r10.sort((a, b) => b.r105.compareTo(a.r105));
    riskAssessment.chol = num.tryParse(bdata.r10.first.r1014);
    riskAssessment.hdl = num.tryParse(bdata.r10.first.r1016);
  }

  ///血壓、血糖機相關資料
  getBps() {
    riskAssessment.systolicBloodPressure =
        userJson['systolicBloodPressure'] == null
            ? null
            : num.tryParse(userJson['systolicBloodPressure']);
    riskAssessment.diastolicBloodPressure =
        userJson['diastolicBloodPressure'] == null
            ? null
            : num.tryParse(userJson['diastolicBloodPressure']);
    riskAssessment.isManual = 0;
  }

  ///分析結果
  ///@refer [HomeBloc.log1p]
  getAnalyzation() {
    List<int> errorCode = []; //解析成功:1，解析失敗:0。
    double outcome = 0;

    if (riskAssessment.aSCVDValidation) {
      if (riskAssessment.gender == '1') {
        outcome = 12.344 * Math.log(riskAssessment.age + 1) +
            11.853 * log1p(riskAssessment.chol) +
            (-2.664) * log1p(riskAssessment.age) * log1p(riskAssessment.chol) +
            (-7.99) * log1p(riskAssessment.hdl) +
            1.769 * log1p(riskAssessment.age) * log1p(riskAssessment.hdl) +
            (riskAssessment.isManual == 1 ? 1.797 : 1.764) *
                log1p(riskAssessment.systolicBloodPressure) +
            7.837 * riskAssessment.smoke +
            (-1.795) * log1p(riskAssessment.age) * riskAssessment.smoke +
            (0.658) * riskAssessment.diabetes;
        outcome = 1 - Math.pow(0.9144, Math.exp(outcome - 61.18));
      } else {
        outcome = (-29.799) * log1p(riskAssessment.age) +
            4.884 * Math.pow(log1p(riskAssessment.age), 2) +
            13.54 * log1p(riskAssessment.chol) +
            (-3.114) * log1p(riskAssessment.age) * log1p(riskAssessment.chol) +
            (-13.578) * log1p(riskAssessment.hdl) +
            3.149 * log1p(riskAssessment.age) * log1p(riskAssessment.hdl) +
            (riskAssessment.isManual == 1 ? 2.019 : 1.957) *
                log1p(riskAssessment.systolicBloodPressure) +
            7.574 * riskAssessment.smoke +
            (-1.665) * log1p(riskAssessment.age) * riskAssessment.smoke +
            0.661 * riskAssessment.diabetes;
        outcome = 1 - Math.pow(0.9665, Math.exp(outcome - (-29.18)));
      }
      riskAssessment.aSCVDRisk = (outcome * 100).toStringAsFixed(2);
      riskAssessment.aSCVD = true;
    } else {
      riskAssessment.aSCVD = false;
    }
    outcome = 0;
    if (riskAssessment.bRAINValidation) {
      double part_1 = -1 *
          0.00186 *
          Math.pow(1.092, (riskAssessment.age - riskAssessment.diabetes - 55)) *
          Math.pow(0.7, riskAssessment.gender == '1' ? 0 : 1) *
          Math.pow(1.547, riskAssessment.smoke) *
          Math.pow(8.544, riskAssessment.heartRate) *
          Math.pow(
              1.122, ((riskAssessment.systolicBloodPressure - 135.5) / 10)) *
          Math.pow(1.138,
              (log1p((riskAssessment.chol / riskAssessment.hdl)) - 5.11));
      double part_2 = Math.pow(1.145, riskAssessment.diabetes);
      double part_3 = (1 - Math.pow(1.145, 10)) / (1 - 1.145);

      outcome = (1 - Math.exp(part_1 * part_2 * part_3));

      riskAssessment.bRAINRisk = (outcome * 100).toStringAsFixed(2);
      riskAssessment.bRAIN = true;
    } else {
      riskAssessment.bRAIN = false;
    }
  }

  ///log1p implementation in gsl standard.(GNU Scientific Library)
  ///@refer https://fossies.org/dox/gsl-2.6/log1p_8c_source.html
  ///@refer http://hk.uwenku.com/question/p-nelqlesv-re.html
  num log1p(num x) {
    num y, z;
    y = 1 + x;
    z = y - 1;
    return Math.log(y) - (z - x) / y;
  }

  ///讀取成人健康檢查的血壓資料
  ///@refer [HomeBloc.hasBloodPressureInfo]
  bool getBloodPressureInfo() {
    try {
      //如果bdata為null，代表無健康存摺資料。
      if (bdata.r10.length <= 0 || hasBloodPressureInfo()) return true;
      bdata.r10.sort((a, b) => b.r105.compareTo(a.r105));
      //更新本地資料
      bloodPressureInfo(
        bdata.r10.first.r1010?.toString() ?? '', //r10.10 血壓檢查_收縮壓
        bdata.r10.first.r1011?.toString() ?? '', //r10.11 血壓檢查_舒張壓
        '[\"0\"]',
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///收縮壓或舒張壓有紀錄，則不讀取健康存摺資料
  bool hasBloodPressureInfo() {
    String systolicBloodPressure = userJson['systolicBloodPressure'];
    String diastolicBloodPressure = userJson['diastolicBloodPressure'];
    if (systolicBloodPressure == null && diastolicBloodPressure == null)
      return false;
    return true;
  }
}
