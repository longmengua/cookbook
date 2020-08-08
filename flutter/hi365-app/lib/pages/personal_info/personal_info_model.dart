class PersonalInfo {
  String address;
  int birthday;
  String email;
  String gender;
  String govId;
  String mobileNumber;
  String name;

  bool get isValid =>
      (name != null && name.isNotEmpty) &&
      (govId != null && govId.isNotEmpty) &&
      (gender != null && gender.isNotEmpty) &&
      birthday != null;

  PersonalInfo({
    this.address,
    this.birthday,
    this.email,
    this.gender,
    this.govId,
    this.mobileNumber,
    this.name,
  });

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    birthday = json['birthday'];
    email = json['email'];
    gender = json['gender'];
    govId = json['govId'];
    mobileNumber = json['mobileNumber'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['govId'] = this.govId;
    data['mobileNumber'] = this.mobileNumber;
    data['name'] = this.name;
    return data;
  }
}
