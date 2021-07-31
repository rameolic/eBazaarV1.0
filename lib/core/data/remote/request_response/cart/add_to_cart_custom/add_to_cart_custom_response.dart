import 'package:thought_factory/utils/app_constants.dart';

class AddToCartCustomResponse {
  int itemId;
  String sku;
  int qty;
  String name;
  String productType;
  String quoteId;
  ProductOption productOption;
  String message;
  int status;

  AddToCartCustomResponse(
      {this.itemId,
        this.sku,
        this.qty,
        this.name,
        this.productType,
        this.quoteId,
        this.productOption});

  AddToCartCustomResponse.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    sku = json['sku'];
    qty = json['qty'];
    name = json['name'];
    productType = json['product_type'];
    quoteId = json['quote_id'];
    productOption = json['product_option'] != null
        ? new ProductOption.fromJson(json['product_option'])
        : null;
    status = AppConstants.RESPONSE_STATUS_SUCCESS;

  }
  AddToCartCustomResponse.fromErrorJson(Map<String, dynamic> json) {
    message = json['message'];
    status = AppConstants.RESPONSE_STATUS_FAILED;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['sku'] = this.sku;
    data['qty'] = this.qty;
    data['name'] = this.name;
    data['product_type'] = this.productType;
    data['quote_id'] = this.quoteId;
    if (this.productOption != null) {
      data['product_option'] = this.productOption.toJson();
    }
    return data;
  }


}

class ProductOption {
  ExtensionAttributes extensionAttributes;

  ProductOption({this.extensionAttributes});

  ProductOption.fromJson(Map<String, dynamic> json) {
    extensionAttributes = json['extension_attributes'] != null
        ? new ExtensionAttributes.fromJson(json['extension_attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    return data;
  }
}

class ExtensionAttributes {
  List<CustomOptions> customOptions;

  ExtensionAttributes({this.customOptions});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    if (json['custom_options'] != null) {
      customOptions = new List<CustomOptions>();
      json['custom_options'].forEach((v) {
        customOptions.add(new CustomOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customOptions != null) {
      data['custom_options'] =
          this.customOptions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomOptions {
  String optionId;
  String optionValue;

  CustomOptions({this.optionId, this.optionValue});

  CustomOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    optionValue = json['option_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['option_value'] = this.optionValue;
    return data;
  }



}