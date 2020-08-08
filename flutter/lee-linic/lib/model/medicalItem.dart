class MedicalItem {
  List<MedicalInfo> medicalInfo;

  MedicalItem({this.medicalInfo});

  MedicalItem.fromJson(Map<String, dynamic> json) {
    if (json['medical_info'] != null) {
      medicalInfo = new List<MedicalInfo>();
      json['medical_info'].forEach((v) {
        medicalInfo.add(new MedicalInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medicalInfo != null) {
      data['medical_info'] = this.medicalInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicalInfo {
  String title;
  String date;
  String doc;
  String detail;

  MedicalInfo({this.title, this.date, this.doc, this.detail});

  MedicalInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    doc = json['doc'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    data['doc'] = this.doc;
    data['detail'] = this.detail;
    return data;
  }
}
