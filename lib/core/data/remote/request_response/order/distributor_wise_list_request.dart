class DistributorWiseListRequest {
  String orderId;

  DistributorWiseListRequest({this.orderId});

  DistributorWiseListRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    return data;
  }
}