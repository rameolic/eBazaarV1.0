class AddToCartResponse {
  int itemId;
  String sku;
  int qty;
  String name;
  double price;
  String productType;
  String quoteId;

  //error fields
  String message;
  Parameters parameters;
  String trace;

  AddToCartResponse(
      {this.itemId,
      this.sku,
      this.qty,
      this.name,
      this.price,
      this.productType,
      this.quoteId,
      this.message,
      this.parameters,
      this.trace});

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    try {
      price = json['price'];
    } catch (e) {
      price = json['price'].toDouble();
    }
    productType = json['product_type'];
    quoteId = json['quote_id'];
    message = json['message'];
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['price'] = this.price;
    data['product_type'] = this.productType;
    data['quote_id'] = this.quoteId;
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
  String fieldValue;

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
