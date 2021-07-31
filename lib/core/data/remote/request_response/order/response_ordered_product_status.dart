class OrderedProductStatusDetailResponse {
  List<Overallstatus> overallstatus;
  List<String> logstatus;
  int status;

  OrderedProductStatusDetailResponse(
      {this.overallstatus, this.logstatus, this.status});

  OrderedProductStatusDetailResponse.fromJson(List<dynamic> jsonArray) {
    Map<String, dynamic> json = jsonArray[0];
    if (json['overallstatus'] != null) {
      overallstatus = new List<Overallstatus>();
      json['overallstatus'].forEach((v) {
        overallstatus.add(new Overallstatus.fromJson(v));
      });
    }
    logstatus = json['logstatus'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overallstatus != null) {
      data['overallstatus'] =
          this.overallstatus.map((v) => v.toJson()).toList();
    }
    data['logstatus'] = this.logstatus;
    data['status'] = this.status;
    return data;
  }
}

class Overallstatus {
  String id;
  String statusLabel;
  String createdAt;
  String updatedAt;

  Overallstatus({this.id, this.statusLabel, this.createdAt, this.updatedAt});

  Overallstatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusLabel = json['status_label'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_label'] = this.statusLabel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}