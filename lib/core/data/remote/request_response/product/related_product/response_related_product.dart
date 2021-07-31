class RelatedProductResponse {
  List<Data> data;
  String message;
  int status;

  RelatedProductResponse({this.data, this.message, this.status});

  RelatedProductResponse.fromJson(List<dynamic> array) {
    Map<String, dynamic> json = array[0];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
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
  String sku;
  String productId;
  String name;
  String productType;
  String price;
  String productImage;
  int productQtyStock;
  bool productAvability;

  Data(
      {this.sku,
      this.productId,
      this.name,
      this.productType,
      this.price,
      this.productImage,
      this.productQtyStock,
      this.productAvability});

  Data.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    productId = json['product_id'];
    name = json['name'];
    productType = json['product_type'];
    price = json['price'];
    productImage = json['product_image'];
    productQtyStock = json['product_qty_stock'];
    productAvability = json['product_avability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['product_type'] = this.productType;
    data['price'] = this.price;
    data['product_image'] = this.productImage;
    data['product_qty_stock'] = this.productQtyStock;
    data['product_avability'] = this.productAvability;
    return data;
  }
}

//class RelatedProductListResponse {
//  String sku;
//  String linkType;
//  String linkedProductSku;
//  String linkedProductType;
//  int position;
//
//
//  RelatedProductListResponse(
//      {this.sku,
//        this.linkType,
//        this.linkedProductSku,
//        this.linkedProductType,
//        this.position});
//
//  RelatedProductListResponse.fromJson(List<dynamic> array, int i) {
//    Map<String, dynamic> json = array[i];
//    sku = json['sku'];
//    linkType = json['link_type'];
//    linkedProductSku = json['linked_product_sku'];
//    linkedProductType = json['linked_product_type'];
//    position = json['position'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['sku'] = this.sku;
//    data['link_type'] = this.linkType;
//    data['linked_product_sku'] = this.linkedProductSku;
//    data['linked_product_type'] = this.linkedProductType;
//    data['position'] = this.position;
//    return data;
//  }
//}
