class RiskAssessment {
  //心臟病
  bool aSCVD; //判斷是否解析成功
  String aSCVDRisk;

  //腦中風
  bool bRAIN; //判斷是否解析成功
  String bRAINRisk;

  //性別，男生：1，女生：0
  String gender;

  //年齡
  num age;

  //抽菸，是：1，否：0
  num smoke;

  //糖尿病病史，是：1，否：0
  num familyHistoryOfDiabetes;

  //糖尿病病期
  num diabetesDuration;

  //糖尿病，是：1，否：0
  num diabetes;

  //心律異常，是：1，否：0
  num heartRate;

  //血脂肪檢查_總膽 固醇(TC)
  num chol;

  //血脂肪檢查_高密 度脂蛋白膽固醇 (HDL)
  num hdl;

  //收縮壓(systolic blood pressure).
  num systolicBloodPressure;

  //舒張壓(diastolic blood pressure).
  num diastolicBloodPressure;

  //是否為自行測量，是：1，否：0
  num isManual;

  @override
  String toString() {
    return 'RiskAssessment{aSCVD: $aSCVD, aSCVDRisk: $aSCVDRisk, bRAIN: $bRAIN, bRAINRisk: $bRAINRisk, gender: $gender, age: $age, smoke: $smoke, familyHistoryOfDiabetes: $familyHistoryOfDiabetes, diabetesDuration: $diabetesDuration, diabetes: $diabetes, heartRate: $heartRate, chol: $chol, hdl: $hdl, systolicBloodPressure: $systolicBloodPressure, diastolicBloodPressure: $diastolicBloodPressure, isManual: $isManual}';
  }

  bool get aSCVDValidation {
    return (age != null && age >= 0) &&
        (smoke != null && smoke >= 0) &&
        (diabetes != null && diabetes >= 0) &&
        (chol != null && chol >= 0) &&
        (hdl != null && hdl >= 0) &&
        (systolicBloodPressure != null && systolicBloodPressure >= 0) &&
        (isManual != null && isManual >= 0);
  }

  bool get bRAINValidation {
    return (age != null && age >= 0) &&
        (smoke != null && smoke >= 0) &&
        (diabetes != null && diabetes >= 0) &&
        (chol != null && chol >= 0) &&
        (hdl != null && hdl >= 0) &&
        (systolicBloodPressure != null && systolicBloodPressure >= 0) &&
        (heartRate != null && heartRate >= 0);
  }
}
