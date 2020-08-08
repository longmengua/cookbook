import 'dart:convert';

class ApiResponse {
  String status;
  bool success;
  String message;
  dynamic data;

  ApiResponse({this.status, this.success, this.message, this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = jsonEncode(this.data);
    }
    return data;
  }
}
