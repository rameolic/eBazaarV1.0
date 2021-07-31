class CreateOrderResponse {
  String message;
  String trace;
  String cartResponseId;

  CreateOrderResponse({this.message, this.trace, this.cartResponseId});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
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
