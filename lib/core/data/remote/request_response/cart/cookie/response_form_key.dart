class FormKeyResponse {
  String data;
  String message;
  int status;

  FormKeyResponse({this.data, this.message, this.status});

  FormKeyResponse.fromJson(List<dynamic> array) {
    Map<String, dynamic> json = array[0];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}