class WishListResponse {
  List<WishList> wishList;

  WishListResponse({this.wishList});

  WishListResponse.fromJson(List<dynamic> jsonArray) {
    wishList = jsonArray.map((item) => WishList.fromJson(item)).toList();
  }
}

class WishList {
  String wishlistItemId;
  String wishlistId;
  String productId;
  String storeId;
  String addedAt;
  String description;
  int qty;
  Product product;

  WishList({
    this.wishlistItemId,
    this.wishlistId,
    this.productId,
    this.storeId,
    this.addedAt,
    this.description,
    this.qty,
    this.product,
  });

  WishList.fromJson(Map<String, dynamic> json) {
    wishlistItemId = json["wishlist_item_id"];
    wishlistId = json["wishlist_id"];
    productId = json["product_id"];
    storeId = json["store_id"];
    addedAt = json["added_at"];
    description = json["description"];
    qty = json["qty"];
    if (json["product"] != null) {
      product = Product.fromJson(json["product"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishlist_item_id'] = wishlistItemId;
    data["wishlist_id"] = wishlistId;
    data["product_id"] = productId;
    data["store_id"] = storeId;
    data["added_at"] = addedAt;
    data["description"] = description;
    data["qty"] = qty;
    data["product"] = product.toJson();
    return data;
  }

  @override
  String toString() {
    return 'WishList{wishlistItemId: $wishlistItemId, wishlistId: $wishlistId, productId: $productId, storeId: $storeId, addedAt: $addedAt, description: $description, qty: $qty, product: $product}';
  }
}

class Product {
  String entityId;
  String attributeSetId;
  String typeId;
  String sku;
  String hasOptions;
  String requiredOptions;
  String createdAt;
  String updatedAt;
  String price;
  String taxClassId;
  String finalPrice;
  String minimalPrice;
  String minPrice;
  String maxPrice;
  String name;
  String smallImage;
  String thumbnail;
  String visibility;
  List<Option> options;
  String requestPath;

  Product({
    this.entityId,
    this.attributeSetId,
    this.typeId,
    this.sku,
    this.hasOptions,
    this.requiredOptions,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.taxClassId,
    this.finalPrice,
    this.minimalPrice,
    this.minPrice,
    this.maxPrice,
    this.name,
    this.smallImage,
    this.thumbnail,
    this.visibility,
    this.options,
    this.requestPath,
  });

  Product.fromJson(Map<String, dynamic> json) {
    entityId = json["entity_id"];
    attributeSetId = json["attribute_set_id"];
    typeId = json["type_id"];
    sku = json["sku"];
    hasOptions = json["has_options"];
    requiredOptions = json["required_options"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    price = json["price"];
    taxClassId = json["tax_class_id"];
    finalPrice = json["final_price"];
    minimalPrice = json["minimal_price"];
    minPrice = json["min_price"];
    maxPrice = json["max_price"];
    name = json["name"];
    smallImage = json["small_image"];
    thumbnail = json["thumbnail"];
    visibility = json["visibility"];
    if (json['options'] != null) {
      options = List<Option>.from(json["options"].map((x) => Option.fromJson(x)));
    }
    requestPath = json["request_path"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["entity_id"] = entityId;
    data["attribute_set_id"] = attributeSetId;
    data["type_id"] = typeId;
    data["sku"] = sku;
    data["has_options"] = hasOptions;
    data["required_options"] = requiredOptions;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["price"] = price;
    data["tax_class_id"] = taxClassId;
    data["final_price"] = finalPrice;
    data["minimal_price"] = minimalPrice;
    data["min_price"] = minPrice;
    data["max_price"] = maxPrice;
    data["name"] = name;
    data["small_image"] = smallImage;
    data["thumbnail"] = thumbnail;
    data["visibility"] = visibility;
    if (this.options != null) {
      data["options"] = List<dynamic>.from(options.map((x) => x.toJson()));
    }
    data["request_path"] = requestPath;
    return data;
  }

  @override
  String toString() {
    return 'Product{entityId: $entityId, attributeSetId: $attributeSetId, typeId: $typeId, sku: $sku, hasOptions: $hasOptions, requiredOptions: $requiredOptions, createdAt: $createdAt, updatedAt: $updatedAt, price: $price, taxClassId: $taxClassId, finalPrice: $finalPrice, minimalPrice: $minimalPrice, minPrice: $minPrice, maxPrice: $maxPrice, name: $name, smallImage: $smallImage, thumbnail: $thumbnail, visibility: $visibility, options: $options, requestPath: $requestPath}';
  }
}

class Option {
  Option();

  factory Option.fromJson(Map<String, dynamic> json) => Option();

  Map<String, dynamic> toJson() => {};
}
