/// Mater model
class CheckupMaster {
  int checkDate;
  String doctorAssessment;
  String hospitalId;
  String hospitalName;
  String id;
  String source;
  String type;
  List<HealthCheckReportAttach> healthCheckReportAttachList;

  CheckupMaster({
    this.checkDate,
    this.doctorAssessment,
    this.hospitalId,
    this.hospitalName,
    this.id,
    this.source,
    this.type,
    this.healthCheckReportAttachList,
  });

  CheckupMaster.fromJson(Map<String, dynamic> json) {
    checkDate = json['checkDate'];
    doctorAssessment = json['doctorAssessment'];
    hospitalId = json['hospitalId'];
    hospitalName = json['hospitalName'];
    id = json['id'];
    source = json['source'];
    type = json['type'];
    if (json['attachInfoFormList'] != null) {
      healthCheckReportAttachList = new List<HealthCheckReportAttach>();
      json['attachInfoFormList'].forEach((v) {
        healthCheckReportAttachList
            .add(new HealthCheckReportAttach.fromJson(v));
      });
    }
    doctorAssessmentFormat();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkDate'] = this.checkDate;
    data['doctorAssessment'] = this.doctorAssessment;
    data['hospitalId'] = this.hospitalId;
    data['hospitalName'] = this.hospitalName;
    data['id'] = this.id;
    data['source'] = this.source;
    data['type'] = this.type;
    return data;
  }

  ///todo: Format the content of doctor assessment.
  void doctorAssessmentFormat(){
//    doctorAssessment = doctorAssessment.replaceAll('\r\n', '');
  }
}

/// Detail model
class CheckupDetail {
  String id;
  String reportCheckItemId;
  String checkItemName;
  String category;
  int seq;
  String valueText;
  String err;
  String refText;
  List<HealthCheckReportAttach> healthCheckReportAttachList;

  CheckupDetail({
    this.id,
    this.reportCheckItemId,
    this.checkItemName,
    this.category,
    this.seq,
    this.valueText,
    this.err,
    this.refText,
    this.healthCheckReportAttachList,
  });

  CheckupDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reportCheckItemId = json['reportCheckItemId'];
    checkItemName = json['checkItemName'];
    category = json['category'];
    seq = json['seq'];
    valueText = json['valueText'];
    err = json['err'];
    refText = json['refText'];
    if (json['healthCheckReportAttachList'] != null) {
      healthCheckReportAttachList = new List<HealthCheckReportAttach>();
      json['healthCheckReportAttachList'].forEach((v) {
        healthCheckReportAttachList
            .add(new HealthCheckReportAttach.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'CheckupDetail{id: $id, reportCheckItemId: $reportCheckItemId, checkItemName: $checkItemName, category: $category, seq: $seq, valueText: $valueText, err: $err, refText: $refText, healthCheckReportAttachList: $healthCheckReportAttachList}';
  }
}

/// Instituion model
class CheckupInstitution {
  String name;
  String hospitalId;
  String id;
  String remark;
  String url;

  CheckupInstitution(
      {this.name, this.hospitalId, this.id, this.remark, this.url});

  CheckupInstitution.fromJson(Map<String, dynamic> json) {
    name = json['hospital']['name'];
    hospitalId = json['hospitalId'];
    id = json['id'];
    remark = json['remark'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['hospitalId'] = this.hospitalId;
    data['id'] = this.id;
    data['remark'] = this.remark;
    data['url'] = this.url;
    return data;
  }
}

class HealthCheckReportAttach {
  String description;
  String url;

  HealthCheckReportAttach({this.description, this.url});

  HealthCheckReportAttach.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['url'] = this.url;
    return data;
  }

  @override
  String toString() {
    return 'HealthCheckReportAttach{description: $description, url: $url}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthCheckReportAttach &&
          runtimeType == other.runtimeType &&
          description == other.description &&
          url == other.url;

  @override
  int get hashCode => description.hashCode ^ url.hashCode;
}
