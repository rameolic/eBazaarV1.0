class OrderedProductStatusDetailRequest {
  String orderId;
  String sellerId;

  OrderedProductStatusDetailRequest({this.orderId, this.sellerId});

  OrderedProductStatusDetailRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    sellerId = json['sellerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['sellerId'] = this.sellerId;
    return data;
  }
}