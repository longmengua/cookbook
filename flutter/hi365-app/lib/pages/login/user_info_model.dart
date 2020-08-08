class UserDetailsModel {
  String personalName;
  String gender;
  String birthdate;
  String organizationId;
  String accountInfoId;
  String govId;
  String personalInfoId;
  String vitalCharacteristicsId;
  String id;
  String username;
  String password;
  bool accountNonExpired;
  bool credentialsNonExpired;
  bool accountNonLocked;
  bool enabled;
  String authorities;

  UserDetailsModel(
      {this.personalName,
        this.gender,
        this.birthdate,
        this.organizationId,
        this.accountInfoId,
        this.govId,
        this.personalInfoId,
        this.vitalCharacteristicsId,
        this.id,
        this.username,
        this.password,
        this.accountNonExpired,
        this.credentialsNonExpired,
        this.accountNonLocked,
        this.enabled,
        this.authorities});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    personalName = json['personalName'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    organizationId = json['organizationId'];
    accountInfoId = json['accountInfoId'];
    govId = json['govId'];
    personalInfoId = json['personalInfoId'];
    vitalCharacteristicsId = json['vitalCharacteristicsId'];
    id = json['id'];
    username = json['username'];
    password = json['password'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    enabled = json['enabled'];
    authorities = json['authorities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalName'] = this.personalName;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['organizationId'] = this.organizationId;
    data['accountInfoId'] = this.accountInfoId;
    data['govId'] = this.govId;
    data['personalInfoId'] = this.personalInfoId;
    data['vitalCharacteristicsId'] = this.vitalCharacteristicsId;
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['enabled'] = this.enabled;
    data['authorities'] = this.authorities;
    return data;
  }
}
