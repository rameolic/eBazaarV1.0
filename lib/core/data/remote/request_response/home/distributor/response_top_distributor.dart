class ResponseTopDistributor {
  List<Data> data;
  String message;
  int status;
  String location;

  ResponseTopDistributor({this.data, this.message, this.status});

  ResponseTopDistributor.fromJson(List<dynamic> json) {
    Map<String, dynamic> mapJson = json[0];
    if (mapJson['data'] != null) {
      data = new List<Data>();
      mapJson['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = mapJson['message'];
    status = mapJson['status'];
  }

  ResponseTopDistributor.fromErrorJson(Map<String, dynamic> json) {
    message = json['message'];
    status = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String id;
  String sellerId;
  String companyName;
  String publicName;
  String distributorName;
  String companyLogoUrl;

  Data(
      {this.id,
      this.sellerId,
      this.companyName,
      this.publicName,
      this.distributorName,
      this.companyLogoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    companyName = json['company_name'];
    publicName = json['public_name'];
    distributorName = json['distributor_name'];
    companyLogoUrl = json['company_logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['company_name'] = this.companyName;
    data['public_name'] = this.publicName;
    data['distributor_name'] = this.distributorName;
    data['company_logo_url'] = this.companyLogoUrl;
    return data;
  }
}
