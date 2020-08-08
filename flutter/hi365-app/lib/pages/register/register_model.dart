class RegisterResult {
  Null data;
  bool success;
  String message;
  String status;

  RegisterResult({
    this.data,
    this.success,
    this.message,
    this.status,
  });

  RegisterResult.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
