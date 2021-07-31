class PopularProductsResponse {
  List<Data> data;
  String message;
  int status;

  PopularProductsResponse({this.data, this.message, this.status});

  PopularProductsResponse.fromJson(List<dynamic> response) {
    if (response != null) {
      Map<String, dynamic> json = response[0];
      if (json['data'] != null) {
        data = new List<Data>();
        json['data'].forEach((v) {
          data.add(new Data.fromJson(v));
        });
      }
      message = json['message'];
      status = json['status'];
    }
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

  @override
  String toString() {
    return 'PopularProductsResponse{data: $data, message: $message, status: $status}';
  }
}

class Data {
  String productName;
  String productId;
  String productSku;
  String productUrl;
  bool productAvability;
  int productQty;
  List<String> productImage;
  String productType;
  String productPrice;
  String specialPrice;
  String customProduct;

  Data(
      {this.productName,
        this.productId,
        this.productSku,
        this.productUrl,
        this.productAvability,
        this.productQty,
        this.productImage,
        this.productType,
      this.productPrice,
      this.specialPrice, this.customProduct});

  Data.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productId = json['product_id'];
    productSku = json['product_sku'];
    productUrl = json['product_url'];
    productAvability = json['product_avability'];
    productQty = json['product_qty'];
    productImage = json['product_image'].cast<String>();
    productType = json['product_type'];
    productPrice = json['product_price'].toString();
    specialPrice = json['product_spl_price'];
    customProduct = json['custom_product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_id'] = this.productId;
    data['product_sku'] = this.productSku;
    data['product_url'] = this.productUrl;
    data['product_avability'] = this.productAvability;
    data['product_qty'] = this.productQty;
    data['product_image'] = this.productImage;
    data['product_type'] = this.productType;
    data['product_price'] = this.productPrice;
    data['product_spl_price'] = this.specialPrice;
    data['custom_product'] = this.customProduct;
    return data;
  }

  @override
  String toString() {
    return 'Data{productName: $productName, productId: $productId, productSku: $productSku, productUrl: $productUrl, productAvability: $productAvability, productQty: $productQty, productImage: $productImage, productType: $productType, productPrice: $productPrice, specialPrice: $specialPrice}';
  }


}