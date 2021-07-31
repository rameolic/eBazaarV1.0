import '../../../../../router.dart';

class ProductResponse {
  List<Items> items;
  SearchCriteria searchCriteria;
  int totalCount;

  ProductResponse({this.items, this.searchCriteria, this.totalCount});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    searchCriteria = json['search_criteria'] != null
        ? new SearchCriteria.fromJson(json['search_criteria'])
        : null;
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.searchCriteria != null) {
      data['search_criteria'] = this.searchCriteria.toJson();
    }
    data['total_count'] = this.totalCount;
    return data;
  }

  @override
  String toString() {
    return 'ProductResponse{items: $items, searchCriteria: $searchCriteria, totalCount: $totalCount}';
  }
}

class Items {
  int id;
  String sku;
  String name;
  int attributeSetId;
  double price;
  int status;
  int visibility;
  String typeId;
  String createdAt;
  String updatedAt;
  List<Null> extensionAttributes;
  List<Null> productLinks;
  List<Null> tierPrices;
  List<Option> options;
  List<CustomAttributes> customAttributes;

  Items(
      {this.id,
        this.sku,
        this.name,
        this.attributeSetId,
        this.price,
        this.status,
        this.visibility,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.extensionAttributes,
        this.productLinks,
        this.tierPrices,
        this.options,
        this.customAttributes});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    attributeSetId = json['attribute_set_id'];

    try{
      price = json['price'];
    } catch (e) {
      int value = json['price'];
      price = value.toDouble();
    }

    status = json['status'];
    visibility = json['visibility'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        customAttributes.add(new CustomAttributes.fromJson(v));
      });
    }

    if (json['options'] != null) {
      log.i("coming ----------> ${json['options']}");
      options = new List<Option>();
      json['options'].forEach((v) {
        options.add(new Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['attribute_set_id'] = this.attributeSetId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['visibility'] = this.visibility;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customAttributes != null) {
      data['custom_attributes'] =
          this.customAttributes.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] =
          this.options.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Items{id: $id, sku: $sku, name: $name, attributeSetId: $attributeSetId, price: $price, status: $status, visibility: $visibility, typeId: $typeId, createdAt: $createdAt, updatedAt: $updatedAt, extensionAttributes: $extensionAttributes, productLinks: $productLinks, tierPrices: $tierPrices, options: $options, customAttributes: $customAttributes}';
  }

}

class CustomAttributes {
  String attributeCode;
  String value;

  CustomAttributes({this.attributeCode, this.value});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    value = json['value'] != null ? json['value'].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_code'] = this.attributeCode;
    data['value'] = this.value;
    return data;
  }

  @override
  String toString() {
    return 'CustomAttributes{attributeCode: $attributeCode, value: $value}';
  }

}

class SearchCriteria {
  List<FilterGroups> filterGroups;
  List<SortOrders> sortOrders;
  int pageSize;
  int currentPage;

  SearchCriteria(
      {this.filterGroups, this.sortOrders, this.pageSize, this.currentPage});

  SearchCriteria.fromJson(Map<String, dynamic> json) {
    if (json['filter_groups'] != null) {
      filterGroups = new List<FilterGroups>();
      json['filter_groups'].forEach((v) {
        filterGroups.add(new FilterGroups.fromJson(v));
      });
    }
    if (json['sort_orders'] != null) {
      sortOrders = new List<SortOrders>();
      json['sort_orders'].forEach((v) {
        sortOrders.add(new SortOrders.fromJson(v));
      });
    }
    pageSize = json['page_size'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filterGroups != null) {
      data['filter_groups'] = this.filterGroups.map((v) => v.toJson()).toList();
    }
    if (this.sortOrders != null) {
      data['sort_orders'] = this.sortOrders.map((v) => v.toJson()).toList();
    }
    data['page_size'] = this.pageSize;
    data['current_page'] = this.currentPage;
    return data;
  }

  @override
  String toString() {
    return 'SearchCriteria{filterGroups: $filterGroups, sortOrders: $sortOrders, pageSize: $pageSize, currentPage: $currentPage}';
  }


}

class FilterGroups {
  List<Filters> filters;

  FilterGroups({this.filters});

  FilterGroups.fromJson(Map<String, dynamic> json) {
    if (json['filters'] != null) {
      filters = new List<Filters>();
      json['filters'].forEach((v) {
        filters.add(new Filters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filters != null) {
      data['filters'] = this.filters.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'FilterGroups{filters: $filters}';
  }


}

class Filters {
  String field;
  String value;
  String conditionType;

  Filters({this.field, this.value, this.conditionType});

  Filters.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    value = json['value'];
    conditionType = json['condition_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['value'] = this.value;
    data['condition_type'] = this.conditionType;
    return data;
  }
}

class SortOrders {
  String field;
  String direction;

  SortOrders({this.field, this.direction});

  SortOrders.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['direction'] = this.direction;
    return data;
  }
}

class ProductLink {
  String sku;
  String linkType;
  String linkedProductSku;
  String linkedProductType;
  int position;
  List<Null> extensionAttributes;

  ProductLink({
    this.sku,
    this.linkType,
    this.linkedProductSku,
    this.linkedProductType,
    this.position,
    this.extensionAttributes,
  });

  ProductLink.fromJson(Map<String, dynamic> json) {
    sku = json["sku"];
    linkType = json["link_type"];
    linkedProductSku = json["linked_product_sku"];
    linkedProductType = json["linked_product_type"];
    position = json["position"];
    //extensionAttributes: List<dynamic>.from(json["extension_attributes"].map((x) => x)),
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["sku"] = sku;
    data["link_type"] = linkType;
    data["linked_product_sku"] = linkedProductSku;
    data["linked_product_type"] = linkedProductType;
    data["position"] =  position;
    return data;
    //"extension_attributes": List<dynamic>.from(extensionAttributes.map((x) => x)),
  }

  @override
  String toString() {
    return 'ProductLink{sku: $sku, linkType: $linkType, linkedProductSku: $linkedProductSku, linkedProductType: $linkedProductType, position: $position, extensionAttributes: $extensionAttributes}';
  }
}

class Option {
  String productSku;
  int optionId;
  String title;
  String type;
  int sortOrder;
  bool isRequire;
  int maxCharacters;
  int imageSizeX;
  int imageSizeY;
  List<ValueElement> values;

  Option({
    this.productSku,
    this.optionId,
    this.title,
    this.type,
    this.sortOrder,
    this.isRequire,
    this.maxCharacters,
    this.imageSizeX,
    this.imageSizeY,
    this.values,
  });

  Option.fromJson(Map<String, dynamic> json) {
    productSku = json["product_sku"];
    optionId = json["option_id"];
    title = json["title"];
    type = json["type"];
    sortOrder = json["sort_order"];
    isRequire = json["is_require"];
    maxCharacters = json["max_characters"];
    imageSizeX = json["image_size_x"];
    imageSizeY = json["image_size_y"];
    if (values != null && values.length > 0) {
      values = List<ValueElement>.from(json["values"].map((x) => ValueElement.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["product_sku"] = productSku;
    data["option_id"] = optionId;
    data["title"] = title;
    data["type"] = type;
    data["sort_order"] = sortOrder;
    data["is_require"] = isRequire;
    data["max_characters"] = maxCharacters;
    data["image_size_x"] = imageSizeX;
    data["image_size_y"] = imageSizeY;
    data["values"] = List<dynamic>.from(values.map((x) => x.toJson()));
    return data;
  }

  @override
  String toString() {
    return 'Option{productSku: $productSku, optionId: $optionId, title: $title, type: $type, sortOrder: $sortOrder, isRequire: $isRequire, maxCharacters: $maxCharacters, imageSizeX: $imageSizeX, imageSizeY: $imageSizeY, values: $values}';
  }


}

class ValueElement {
  String title;
  int sortOrder;
  int price;
  String priceType;
  String sku;
  int optionTypeId;

  ValueElement({
    this.title,
    this.sortOrder,
    this.price,
    this.priceType,
    this.sku,
    this.optionTypeId,
  });

  ValueElement.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    sortOrder = json["sort_order"];
    price = json["price"];
    priceType = json["price_type"];
    sku = json["sku"];
    optionTypeId = json["option_type_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["title"] = title;
    data["sort_order"] = sortOrder;
    data["price"] = price;
    data["price_type"] = priceType;
    data["sku"] = sku;
    data["option_type_id"] = optionTypeId;
    return data;
  }

  @override
  String toString() {
    return 'ValueElement{title: $title, sortOrder: $sortOrder, price: $price, priceType: $priceType, sku: $sku, optionTypeId: $optionTypeId}';
  }


}




