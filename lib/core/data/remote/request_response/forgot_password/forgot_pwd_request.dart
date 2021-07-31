class ForgotPwdRequest {
  String email;
  String template;

  ForgotPwdRequest({this.email, this.template});

  ForgotPwdRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    template = json['template'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['template'] = this.template;
    return data;
  }
}