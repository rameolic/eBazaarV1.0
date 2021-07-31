class CreateOrderRequest {
  String cartId;
  PaymentMethod paymentMethod;
  ShippingMethod shippingMethod;

  CreateOrderRequest({this.cartId,this.paymentMethod, this.shippingMethod});

  CreateOrderRequest.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    paymentMethod = json['paymentMethod'] != null ? new PaymentMethod.fromJson(json['paymentMethod']) : null;
    shippingMethod = json['shippingMethod'] != null ? new ShippingMethod.fromJson(json['shippingMethod']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    if (this.paymentMethod != null) {
      data['paymentMethod'] = this.paymentMethod.toJson();
    }
    if (this.shippingMethod != null) {
      data['shippingMethod'] = this.shippingMethod.toJson();
    }

    return data;
  }
}

class PaymentMethod {
  String method;

  PaymentMethod({this.method});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    return data;
  }
}

class ShippingMethod {
  String methodCode;
  String carrierCode;
  AdditionalProperties additionalProperties;

  ShippingMethod({this.methodCode, this.carrierCode, this.additionalProperties});

  ShippingMethod.fromJson(Map<String, dynamic> json) {
    methodCode = json['method_code'];
    carrierCode = json['carrier_code'];
    additionalProperties = json['additionalProperties'] != null ? new AdditionalProperties.fromJson(json['additionalProperties']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_code'] = this.methodCode;
    data['carrier_code'] = this.carrierCode;
    if (this.additionalProperties != null) {
      data['additionalProperties'] = this.additionalProperties.toJson();
    }
    return data;
  }
}

class AdditionalProperties {


  AdditionalProperties();

AdditionalProperties.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}