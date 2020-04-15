import 'package:intl/intl.dart';

class HealthBankMasterPage {
  final int page;
  final int start;
  final int limit;
  final int total;
  final bool success;
  final String message;
  final List<HealthBankMaster> data;



  HealthBankMasterPage(
      {this.page,
      this.start,
      this.limit,
      this.total,
      this.success,
      this.message,
      this.data});

  factory HealthBankMasterPage.fromJson(Map<String, dynamic> jsonData) {
    var list = jsonData['data'] as List;
    //print(list.runtimeType);

    List<HealthBankMaster> masterlist =
        list.map((i) => HealthBankMaster.fromJson(i)).toList();

    return HealthBankMasterPage(
      page: jsonData['page'],
      start: jsonData['start'],
      limit: jsonData['limit'],
      total: jsonData['total'],
      success: jsonData['success'],
      message: jsonData['message'],
      data: masterlist,
    );
  }
}

class HealthBankMaster {
  final String id;
  final String hospitalCode;
  final String applyDate;
  final String cardSeq;
  final String dataTime1;
  final String dataTime2;
  final String diseaseCode;
  final String diseaseName;
  final String govId;
  final String healthBankFileId;
  final String hospitalId;
  final String hospitalName;
  final String otherCode;
  final String otherField;
  final String otherName;
  final String procedureCode;
  final String procedureName;
  final String type;
  final String vitalCharacteristicsId;
  final List<HealthBankDetail> details;

  HealthBankMaster({
    this.id,
    this.hospitalCode,
    this.applyDate,
    this.cardSeq,
    this.dataTime1,
    this.dataTime2,
    this.diseaseCode,
    this.diseaseName,
    this.govId,
    this.healthBankFileId,
    this.hospitalId,
    this.hospitalName,
    this.otherCode,
    this.otherField,
    this.otherName,
    this.procedureCode,
    this.procedureName,
    this.type,
    this.vitalCharacteristicsId,
    this.details,
  });
  //https://stackoverflow.com/questions/53962129/how-to-check-for-null-when-mapping-nested-json
  factory HealthBankMaster.fromJson(Map<String, dynamic> jsonData) {
    var list = jsonData['details'] as List;
    //print(list.runtimeType);
    var formatter = new DateFormat('yyyy-MM-dd');

    return HealthBankMaster(
        id: jsonData['id'],
        hospitalCode: jsonData['hospitalCode'],
        applyDate: jsonData['applyDate'] == null ? null : formatter.format(DateTime.fromMillisecondsSinceEpoch(jsonData['applyDate'])),
        cardSeq: jsonData['cardSeq'],
        dataTime1: jsonData['dataTime1'] == null ? null :formatter.format(DateTime.fromMillisecondsSinceEpoch(jsonData['dataTime1'])),
        dataTime2: jsonData['dataTime2'] == null ? null :formatter.format(DateTime.fromMillisecondsSinceEpoch(jsonData['dataTime2'])),
        diseaseCode: jsonData['diseaseCode'],
        diseaseName: jsonData['diseaseName'],
        govId: jsonData['govId'],
        healthBankFileId: jsonData['healthBankFileId'],
        hospitalId: jsonData['hospitalId'],
        hospitalName: jsonData['hospitalName'],
        otherCode: jsonData['otherCode'],
        otherField: jsonData['otherField'],
        otherName: jsonData['otherName'],
        procedureCode: jsonData['procedureCode'],
        procedureName: jsonData['procedureName'],
        type: jsonData['type'],
        vitalCharacteristicsId: jsonData['vitalCharacteristicsId'],
        details: list == null
            ? null
            : list.map((i) => HealthBankDetail.fromJson(i)).toList());
  }
}

class HealthBankDetail {
  final String beginDate;
  final String endDate;
  final String id;
  final String itemName;
  final String itemValue;
  final String itemStd;
  final int medDays;
  final String orderCode;
  final String orderName;
  final String seq;
  final String teethCode;
  final String teethName;
  final double totalCount;

  HealthBankDetail({
    this.beginDate,
    this.endDate,
    this.id,
    this.itemName,
    this.itemValue,
    this.itemStd,
    this.medDays,
    this.orderCode,
    this.orderName,
    this.seq,
    this.teethCode,
    this.teethName,
    this.totalCount,
  });

  factory HealthBankDetail.fromJson(Map<String, dynamic> jsonData) {
       var formatter = new DateFormat('yyyy-MM-dd');
    return HealthBankDetail(
      beginDate: jsonData['beginDate'] == null ? null : formatter.format(DateTime.fromMillisecondsSinceEpoch(jsonData['beginDate'])),
      endDate: jsonData['endDate'] == null ? null : formatter.format(DateTime.fromMillisecondsSinceEpoch(jsonData['endDate'])),
      id: jsonData['id'],
      itemName: jsonData['itemName'],
      itemValue: jsonData['itemValue'],
      itemStd: jsonData['itemStd'],
      medDays: jsonData['medDays'],
      orderCode: jsonData['orderCode'],
      orderName: jsonData['orderName'],
      seq: jsonData['seq'],
      teethCode: jsonData['teethCode'],
      teethName: jsonData['teethName'],
      totalCount: jsonData['totalCount'],
    );
  }
}
