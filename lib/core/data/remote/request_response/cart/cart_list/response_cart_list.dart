class CartListResponse {
  int cartCount;
  List<Data> data;
  String message;
  int status;

  CartListResponse({this.cartCount, this.data, this.message, this.status});

  CartListResponse.fromJson(List<dynamic> json) {
    Map<String, dynamic> mapJson = json[0];
    cartCount = mapJson['cart_count'];
    if (mapJson['data'] != null) {
      data = new List<Data>();
      mapJson['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = mapJson['message'];
    status = mapJson['status'];
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
    return 'CartListResponse{cartCount: $cartCount, data: $data, message: $message, status: $status}';
  }
}

class Data {
  String sellerId;
  String shopName;
  List<ProductList> productList;
  bool isExpand = true;

  Data({this.sellerId, this.shopName, this.productList, this.isExpand});

  Data.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    shopName = json['shop_name'];
    if (json['product_list'] != null) {
      productList = new List<ProductList>();
      json['product_list'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;
    data['shop_name'] = this.shopName;
    if (this.productList != null) {
      data['product_list'] = this.productList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Data{sellerId: $sellerId, shopName: $shopName, productList: $productList, isExpand: $isExpand}';
  }
}

class ProductList {
  String quoteId;
  String itemId;
  String productName;
  String productId;
  String productSku;
  int productQty;
  String productPrice;
  String productSplPrice;
  String productImage;
  String productType;
  int productQtyStock;
  bool productAvability;
  ProductOptions productOptions;

  ProductList(
      {this.quoteId,
      this.itemId,
      this.productName,
      this.productId,
      this.productSku,
      this.productQty,
      this.productPrice,
      this.productSplPrice,
      this.productImage,
      this.productType,
      this.productQtyStock,
      this.productAvability,
      this.productOptions});

  ProductList.fromJson(Map<String, dynamic> json) {
    quoteId = json['quote_id'];
    itemId = json['item_id'];
    productName = json['product_name'];
    productId = json['product_id'];
    productSku = json['product_sku'];
    productQty = json['product_qty'];
    productPrice = json['product_price'];
    productSplPrice = json['product_spl_price'];
    productImage = json['product_image'] ?? '';
    productType = json['product_type'];
    productQtyStock = json['product_qty_stock'];
    productAvability = json['product_avability'];
    try {
      productOptions = json['product_options'] != null
          ? new ProductOptions.fromJson(json['product_options'])
          : null;
    } catch (e) {
      productOptions = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote_id'] = this.quoteId;
    data['item_id'] = this.itemId;
    data['product_name'] = this.productName;
    data['product_id'] = this.productId;
    data['product_sku'] = this.productSku;
    data['product_qty'] = this.productQty;
    data['product_price'] = this.productPrice;
    data['product_spl_price'] = this.productSplPrice;
    data['product_image'] = this.productImage;
    data['product_type'] = this.productType;
    data['product_qty_stock'] = this.productQtyStock;
    data['product_avability'] = this.productAvability;
    if (this.productOptions != null) {
      data['product_options'] = this.productOptions.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ProductList{quoteId: $quoteId, itemId: $itemId, productName: $productName, productId: $productId, productSku: $productSku, productQty: $productQty, productPrice: $productPrice, productSplPrice: $productSplPrice, productImage: $productImage, productType: $productType, productQtyStock: $productQtyStock, productAvability: $productAvability, productOptions: $productOptions}';
  }
}

class ProductOptions {
  String optionId;
  String label;
  String value;

  ProductOptions({this.optionId, this.label, this.value});

  ProductOptions.fromJson(Map<String, dynamic> json) {
    optionId = json['option_id'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['option_id'] = this.optionId;
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }

  @override
  String toString() {
    return 'ProductOptions{optionId: $optionId, label: $label, value: $value}';
  }
}
