class LoginModel {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;

  LoginModel({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.expiresIn,
    this.scope,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    data['scope'] = this.scope;
    return data;
  }
}
