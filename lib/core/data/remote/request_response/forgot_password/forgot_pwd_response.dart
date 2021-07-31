class ForgotPwdResponse {
  String message;
  String trace;
  bool isSuccess = false;

  ForgotPwdResponse({this.message, this.trace, this.isSuccess});

  ForgotPwdResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['trace'] = this.trace;
    return data;
  }
}