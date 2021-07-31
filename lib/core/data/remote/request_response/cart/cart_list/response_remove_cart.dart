class RemoveCartResponse {
  String message;
  String trace;
  bool status;

  RemoveCartResponse({this.message, this.trace, this.status});

  RemoveCartResponse.fromJson(Map<String, dynamic> json) {
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