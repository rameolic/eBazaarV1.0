class ErrorResponse {
  String message;
  List<String> parameters;
  String trace;

  ErrorResponse({this.message, this.parameters, this.trace});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    parameters = json['parameters'].cast<String>();
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['parameters'] = this.parameters;
    data['trace'] = this.trace;
    return data;
  }
}
