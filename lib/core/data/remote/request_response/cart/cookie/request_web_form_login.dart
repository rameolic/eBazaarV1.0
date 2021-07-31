class WebFormLoginRequest {
  String formKey;
  String username;
  String password;
  int otp = 1;

  WebFormLoginRequest({this.formKey, this.username, this.password,this.otp });

  WebFormLoginRequest.fromJson(Map<String, dynamic> json) {
    formKey = json['form_key'];
    username = json['username'];
    password = json['password'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['form_key'] = this.formKey;
    data['username'] = this.username;
    this.password==null||this.password==""? data['otp'] = 1:data['password'] = this.password;
    return data;
  }
}