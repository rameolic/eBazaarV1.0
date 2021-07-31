class WebFormLoginResponse {
  bool errors;

  WebFormLoginResponse({this.errors});

  WebFormLoginResponse.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errors'] = this.errors;
    return data;
  }
}