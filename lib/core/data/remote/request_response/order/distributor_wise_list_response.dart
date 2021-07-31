class DistributorWiseListResponse {
  Data data;
  String message;
  int status;

  DistributorWiseListResponse({this.data, this.message, this.status});

  DistributorWiseListResponse.fromJson(List<dynamic> jsonArray) {
    Map<String, dynamic> json = jsonArray[0];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  List<OrderedItemList> orderedItemList;

  Data({this.orderedItemList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ordered_item_list'] != null) {
      orderedItemList = new List<OrderedItemList>();
      json['ordered_item_list'].forEach((v) {
        orderedItemList.add(new OrderedItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderedItemList != null) {
      data['ordered_item_list'] =
          this.orderedItemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderedItemList {
  String shopName;
  List<ShippingStatus> shippingStatus;
  String shippingMethod;
  String productId;
  String productName;
  String productSku;
  int quantity;
  String price;
  String total;
  List<CustomOption> customOption;

  OrderedItemList(
      {this.shopName,
        this.shippingStatus,
        this.shippingMethod,
        this.productId,
        this.productName,
        this.productSku,
        this.quantity,
        this.price,
        this.total,
        this.customOption});

  OrderedItemList.fromJson(Map<String, dynamic> json) {
    shopName = json['shop_name'];
    if (json['shipping_status'] != null) {
      shippingStatus = new List<ShippingStatus>();
      json['shipping_status'].forEach((v) {
        shippingStatus.add(new ShippingStatus.fromJson(v));
      });
    }
    shippingMethod = json['shipping_method'];
    productId = json['product_id'];
    productName = json['product_name'];
    productSku = json['product_sku'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['Total'];
    if (json['custom_option'] != null) {
      customOption = new List<CustomOption>();
      json['custom_option'].forEach((v) {
        customOption.add(new CustomOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_name'] = this.shopName;
    if (this.shippingStatus != null) {
      data['shipping_status'] =
          this.shippingStatus.map((v) => v.toJson()).toList();
    }
    data['shipping_method'] = this.shippingMethod;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_sku'] = this.productSku;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['Total'] = this.total;
    if (this.customOption != null) {
      data['custom_option'] = this.customOption.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingStatus {
  List<Overallstatus> overallstatus;
  List<String> logstatus;
  int status;

  ShippingStatus({this.overallstatus, this.logstatus, this.status});

  ShippingStatus.fromJson(Map<String, dynamic> json) {
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

class CustomOption {
  String label;
  String value;
  String printValue;
  String optionId;
  String optionType;
  String optionValue;
  bool customView;

  CustomOption(
      {this.label,
        this.value,
        this.printValue,
        this.optionId,
        this.optionType,
        this.optionValue,
        this.customView});

  CustomOption.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    printValue = json['print_value'];
    optionId = json['option_id'];
    optionType = json['option_type'];
    optionValue = json['option_value'];
    customView = json['custom_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['print_value'] = this.printValue;
    data['option_id'] = this.optionId;
    data['option_type'] = this.optionType;
    data['option_value'] = this.optionValue;
    data['custom_view'] = this.customView;
    return data;
  }
}
//class DistributorWiseListResponse {
//  Data data;
//  String message;
//  int status;
//
//  DistributorWiseListResponse({this.data, this.message, this.status});
//
//  DistributorWiseListResponse.fromJson(List<dynamic> jsonArray) {
//    Map<String, dynamic> json = jsonArray[0];
//    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//    message = json['message'];
//    status = json['status'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    data['message'] = this.message;
//    data['status'] = this.status;
//    return data;
//  }
//}
//
//class Data {
//  List<OrderedItemList> orderedItemList;
//
//  Data({this.orderedItemList});
//
//  Data.fromJson(Map<String, dynamic> json) {
//    if (json['ordered_item_list'] != null) {
//      orderedItemList = new List<OrderedItemList>();
//      json['ordered_item_list'].forEach((v) {
//        orderedItemList.add(new OrderedItemList.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.orderedItemList != null) {
//      data['ordered_item_list'] =
//          this.orderedItemList.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class OrderedItemList {
//  String shopName;
//  List<ShippingStatus> shippingStatus;
//  String productId;
//  String productName;
//  String productSku;
//  int quantity;
//  String price;
//  String total;
//
//  OrderedItemList(
//      {this.shopName,
//        this.shippingStatus,
//        this.productId,
//        this.productName,
//        this.productSku,
//        this.quantity,
//        this.price,
//        this.total});
//
//  OrderedItemList.fromJson(Map<String, dynamic> json) {
//    shopName = json['shop_name'];
//    if (json['shipping_status'] != null) {
//      shippingStatus = new List<ShippingStatus>();
//      json['shipping_status'].forEach((v) {
//        shippingStatus.add(new ShippingStatus.fromJson(v));
//      });
//    }
//    productId = json['product_id'];
//    productName = json['product_name'];
//    productSku = json['product_sku'];
//    quantity = json['quantity'];
//    price = json['price'];
//    total = json['Total'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['shop_name'] = this.shopName;
//    if (this.shippingStatus != null) {
//      data['shipping_status'] =
//          this.shippingStatus.map((v) => v.toJson()).toList();
//    }
//    data['product_id'] = this.productId;
//    data['product_name'] = this.productName;
//    data['product_sku'] = this.productSku;
//    data['quantity'] = this.quantity;
//    data['price'] = this.price;
//    data['Total'] = this.total;
//    return data;
//  }
//}
//
//class ShippingStatus {
//  List<Overallstatus> overallstatus;
//  List<String> logstatus;
//  int status;
//
//  ShippingStatus({this.overallstatus, this.logstatus, this.status});
//
//  ShippingStatus.fromJson(Map<String, dynamic> json) {
//    if (json['overallstatus'] != null) {
//      overallstatus = new List<Overallstatus>();
//      json['overallstatus'].forEach((v) {
//        overallstatus.add(new Overallstatus.fromJson(v));
//      });
//    }
//    logstatus = json['logstatus'].cast<String>();
//    status = json['status'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.overallstatus != null) {
//      data['overallstatus'] =
//          this.overallstatus.map((v) => v.toJson()).toList();
//    }
//    data['logstatus'] = this.logstatus;
//    data['status'] = this.status;
//    return data;
//  }
//}
//
//class Overallstatus {
//  String id;
//  String statusLabel;
//  String createdAt;
//  String updatedAt;
//
//  Overallstatus({this.id, this.statusLabel, this.createdAt, this.updatedAt});
//
//  Overallstatus.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    statusLabel = json['status_label'];
//    createdAt = json['created_at'];
//    updatedAt = json['updated_at'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['status_label'] = this.statusLabel;
//    data['created_at'] = this.createdAt;
//    data['updated_at'] = this.updatedAt;
//    return data;
//  }
//}