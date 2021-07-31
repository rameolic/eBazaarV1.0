class RemoveCouponResponse {
  String message;
  Parameters parameters;
  String trace;
  bool flag = false;

  RemoveCouponResponse({this.message, this.parameters, this.trace, this.flag});

  RemoveCouponResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.parameters != null) {
      data['parameters'] = this.parameters.toJson();
    }
    data['trace'] = this.trace;
    return data;
  }
}

class Parameters {
  String fieldName;
  int fieldValue;

  Parameters({this.fieldName, this.fieldValue});

  Parameters.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    fieldValue = json['fieldValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['fieldValue'] = this.fieldValue;
    return data;
  }
}