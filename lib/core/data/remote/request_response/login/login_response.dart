class LoginResponse {
  String message;
  String trace;
  String token;

  LoginResponse({this.message, this.trace, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
