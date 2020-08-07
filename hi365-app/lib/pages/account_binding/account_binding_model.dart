class BindingInfo {
  String accountInfoName;
  int birthday;
  String name;
  String organization;

  BindingInfo({
    this.accountInfoName,
    this.birthday,
    this.name,
    this.organization,
  });

  BindingInfo.fromJson(Map<String, dynamic> json) {
    accountInfoName = json['accountInfoName'];
    birthday = json['birthday'];
    name = json['name'];
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountInfoName'] = this.accountInfoName;
    data['birthday'] = this.birthday;
    data['name'] = this.name;
    data['organization'] = this.organization;
    return data;
  }
}
