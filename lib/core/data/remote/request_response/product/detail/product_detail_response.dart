import 'package:thought_factory/utils/app_constants.dart';

class ProductDetailResponse {
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
  ExtensionAttributes extensionAttributes;
  List<ProductLinks> productLinks;
  List<Options> options;
  List<MediaGalleryEntries> mediaGalleryEntries;
  //List<Null> tierPrices;
  List<CustomAttributes> customAttributes;
  String message;

  ProductDetailResponse(
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
      this.options,
      this.mediaGalleryEntries,
      //this.tierPrices,
      this.customAttributes,
      this.message});

  ProductDetailResponse.fromJson(Map<String, dynamic> json) {
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
    extensionAttributes =
        json['extension_attributes'] != null ? new ExtensionAttributes.fromJson(json['extension_attributes']) : null;
    if (json['product_links'] != null) {
      productLinks = new List<ProductLinks>();
      json['product_links'].forEach((v) {
        productLinks.add(new ProductLinks.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = new List<Options>();
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    if (json['media_gallery_entries'] != null) {
      mediaGalleryEntries = new List<MediaGalleryEntries>();
      json['media_gallery_entries'].forEach((v) {
        mediaGalleryEntries.add(new MediaGalleryEntries.fromJson(v));
      });
    }
    /*if (json['tier_prices'] != null) {
      tierPrices = new List<Null>();
      json['tier_prices'].forEach((v) { tierPrices.add(new Null.fromJson(v)); });
    }*/
    if (json['custom_attributes'] != null) {
      customAttributes = new List<CustomAttributes>();
      json['custom_attributes'].forEach((v) {
        Map<String, dynamic> json = v;
        if (json['attribute_code'] != 'category_ids') {
          customAttributes.add(new CustomAttributes.fromJson(v));
        }
      });
    }
    status = AppConstants.RESPONSE_STATUS_SUCCESS;
  }

  ProductDetailResponse.fromErrorJson(Map<String, dynamic> json) {
    message = json['message'];
   status = AppConstants.RESPONSE_STATUS_FAILED;
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
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.toJson();
    }
    if (this.productLinks != null) {
      data['product_links'] = this.productLinks.map((v) => v.toJson()).toList();
    }
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    if (this.mediaGalleryEntries != null) {
      data['media_gallery_entries'] = this.mediaGalleryEntries.map((v) => v.toJson()).toList();
    }
    /*  if (this.tierPrices != null) {
      data['tier_prices'] = this.tierPrices.map((v) => v.toJson()).toList();
    }*/
    if (this.customAttributes != null) {
      data['custom_attributes'] = this.customAttributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtensionAttributes {
  StockItem stockItem;
  List<ConfigurableProductOptions> configurableProductOptions;
  List<int> configurableProductLinks;

  ExtensionAttributes({this.stockItem, this.configurableProductOptions, this.configurableProductLinks});

  ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    stockItem = json['stock_item'] != null ? new StockItem.fromJson(json['stock_item']) : null;
    if (json['configurable_product_options'] != null) {
      configurableProductOptions = new List<ConfigurableProductOptions>();
      json['configurable_product_options'].forEach((v) {
        configurableProductOptions.add(new ConfigurableProductOptions.fromJson(v));
      });
    }
    if (json['configurable_product_links'] != null) {
      configurableProductLinks = json['configurable_product_links'].cast<int>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stockItem != null) {
      data['stock_item'] = this.stockItem.toJson();
    }
    if (this.configurableProductOptions != null) {
      data['configurable_product_options'] = this.configurableProductOptions.map((v) => v.toJson()).toList();
    }
    data['configurable_product_links'] = this.configurableProductLinks;
    return data;
  }
}

class StockItem {
  int itemId;
  int productId;
  int stockId;
  int qty;
  bool isInStock;
  bool isQtyDecimal;
  bool showDefaultNotificationMessage;
  bool useConfigMinQty;
  int minQty;
  int useConfigMinSaleQty;
  int minSaleQty;
  bool useConfigMaxSaleQty;
  int maxSaleQty;
  bool useConfigBackorders;
  int backorders;
  bool useConfigNotifyStockQty;
  int notifyStockQty;
  bool useConfigQtyIncrements;
  int qtyIncrements;
  bool useConfigEnableQtyInc;
  bool enableQtyIncrements;
  bool useConfigManageStock;
  bool manageStock;
  String lowStockDate;
  bool isDecimalDivided;
  int stockStatusChangedAuto;

  StockItem(
      {this.itemId,
      this.productId,
      this.stockId,
      this.qty,
      this.isInStock,
      this.isQtyDecimal,
      this.showDefaultNotificationMessage,
      this.useConfigMinQty,
      this.minQty,
      this.useConfigMinSaleQty,
      this.minSaleQty,
      this.useConfigMaxSaleQty,
      this.maxSaleQty,
      this.useConfigBackorders,
      this.backorders,
      this.useConfigNotifyStockQty,
      this.notifyStockQty,
      this.useConfigQtyIncrements,
      this.qtyIncrements,
      this.useConfigEnableQtyInc,
      this.enableQtyIncrements,
      this.useConfigManageStock,
      this.manageStock,
      this.lowStockDate,
      this.isDecimalDivided,
      this.stockStatusChangedAuto});

  StockItem.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    productId = json['product_id'];
    stockId = json['stock_id'];
    qty = json['qty'];
    isInStock = json['is_in_stock'];
    isQtyDecimal = json['is_qty_decimal'];
    showDefaultNotificationMessage = json['show_default_notification_message'];
    useConfigMinQty = json['use_config_min_qty'];
    minQty = json['min_qty'];
    useConfigMinSaleQty = json['use_config_min_sale_qty'];
    minSaleQty = json['min_sale_qty'];
    useConfigMaxSaleQty = json['use_config_max_sale_qty'];
    maxSaleQty = json['max_sale_qty'];
    useConfigBackorders = json['use_config_backorders'];
    backorders = json['backorders'];
    useConfigNotifyStockQty = json['use_config_notify_stock_qty'];
    notifyStockQty = json['notify_stock_qty'];
    useConfigQtyIncrements = json['use_config_qty_increments'];
    qtyIncrements = json['qty_increments'];
    useConfigEnableQtyInc = json['use_config_enable_qty_inc'];
    enableQtyIncrements = json['enable_qty_increments'];
    useConfigManageStock = json['use_config_manage_stock'];
    manageStock = json['manage_stock'];
    lowStockDate = json['low_stock_date'];
    isDecimalDivided = json['is_decimal_divided'];
    stockStatusChangedAuto = json['stock_status_changed_auto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['product_id'] = this.productId;
    data['stock_id'] = this.stockId;
    data['qty'] = this.qty;
    data['is_in_stock'] = this.isInStock;
    data['is_qty_decimal'] = this.isQtyDecimal;
    data['show_default_notification_message'] = this.showDefaultNotificationMessage;
    data['use_config_min_qty'] = this.useConfigMinQty;
    data['min_qty'] = this.minQty;
    data['use_config_min_sale_qty'] = this.useConfigMinSaleQty;
    data['min_sale_qty'] = this.minSaleQty;
    data['use_config_max_sale_qty'] = this.useConfigMaxSaleQty;
    data['max_sale_qty'] = this.maxSaleQty;
    data['use_config_backorders'] = this.useConfigBackorders;
    data['backorders'] = this.backorders;
    data['use_config_notify_stock_qty'] = this.useConfigNotifyStockQty;
    data['notify_stock_qty'] = this.notifyStockQty;
    data['use_config_qty_increments'] = this.useConfigQtyIncrements;
    data['qty_increments'] = this.qtyIncrements;
    data['use_config_enable_qty_inc'] = this.useConfigEnableQtyInc;
    data['enable_qty_increments'] = this.enableQtyIncrements;
    data['use_config_manage_stock'] = this.useConfigManageStock;
    data['manage_stock'] = this.manageStock;
    data['low_stock_date'] = this.lowStockDate;
    data['is_decimal_divided'] = this.isDecimalDivided;
    data['stock_status_changed_auto'] = this.stockStatusChangedAuto;
    return data;
  }
}

class ConfigurableProductOptions {
  int id;
  String attributeId;
  String label;
  int position;
  List<ValuesCpOptions> values;
  int productId;

  ConfigurableProductOptions({this.id, this.attributeId, this.label, this.position, this.values, this.productId});

  ConfigurableProductOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeId = json['attribute_id'];
    label = json['label'];
    position = json['position'];
    if (json['values'] != null) {
      values = new List<ValuesCpOptions>();
      json['values'].forEach((v) {
        values.add(new ValuesCpOptions.fromJson(v));
      });
    }
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_id'] = this.attributeId;
    data['label'] = this.label;
    data['position'] = this.position;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    data['product_id'] = this.productId;
    return data;
  }
}

class ValuesCpOptions {
  int valueIndex;

  ValuesCpOptions({this.valueIndex});

  ValuesCpOptions.fromJson(Map<String, dynamic> json) {
    valueIndex = json['value_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_index'] = this.valueIndex;
    return data;
  }
}

class ProductLinks {
  String sku;
  String linkType;
  String linkedProductSku;
  String linkedProductType;
  int position;
  List<ExtensionAttributes> extensionAttributes;

  ProductLinks(
      {this.sku,
      this.linkType,
      this.linkedProductSku,
      this.linkedProductType,
      this.position,
      this.extensionAttributes});

  ProductLinks.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    linkType = json['link_type'];
    linkedProductSku = json['linked_product_sku'];
    linkedProductType = json['linked_product_type'];
    position = json['position'];
    if (json['extension_attributes'] != null) {
      extensionAttributes = new List<ExtensionAttributes>();
      json['extension_attributes'].forEach((v) {
        extensionAttributes.add(new ExtensionAttributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['link_type'] = this.linkType;
    data['linked_product_sku'] = this.linkedProductSku;
    data['linked_product_type'] = this.linkedProductType;
    data['position'] = this.position;
    if (this.extensionAttributes != null) {
      data['extension_attributes'] = this.extensionAttributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String productSku;
  int optionId;
  String title;
  String type;
  int sortOrder;
  bool isRequire;
  int maxCharacters;
  int imageSizeX;
  int imageSizeY;
  List<ValuesOptions> values;

  Options(
      {this.productSku,
      this.optionId,
      this.title,
      this.type,
      this.sortOrder,
      this.isRequire,
      this.maxCharacters,
      this.imageSizeX,
      this.imageSizeY,
      this.values});

  Options.fromJson(Map<String, dynamic> json) {
    productSku = json['product_sku'];
    optionId = json['option_id'];
    title = json['title'];
    type = json['type'];
    sortOrder = json['sort_order'];
    isRequire = json['is_require'];
    maxCharacters = json['max_characters'];
    imageSizeX = json['image_size_x'];
    imageSizeY = json['image_size_y'];
    if (json['values'] != null) {
      values = new List<ValuesOptions>();
      json['values'].forEach((v) {
        values.add(new ValuesOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_sku'] = this.productSku;
    data['option_id'] = this.optionId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['sort_order'] = this.sortOrder;
    data['is_require'] = this.isRequire;
    data['max_characters'] = this.maxCharacters;
    data['image_size_x'] = this.imageSizeX;
    data['image_size_y'] = this.imageSizeY;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValuesOptions {
  String title;
  int sortOrder;
  double price;
  String priceType;
  String sku;
  int optionTypeId;

  ValuesOptions({this.title, this.sortOrder, this.price, this.priceType, this.sku, this.optionTypeId});

  ValuesOptions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    sortOrder = json['sort_order'];
    price = json['price'] != null ? double.parse(json['price'].toString()) : 0;
    priceType = json['price_type'];
    sku = json['sku'];
    optionTypeId = json['option_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['sort_order'] = this.sortOrder;
    data['price'] = this.price;
    data['price_type'] = this.priceType;
    data['sku'] = this.sku;
    data['option_type_id'] = this.optionTypeId;
    return data;
  }
}

class MediaGalleryEntries {
  int id;
  String mediaType;
  String label;
  int position;
  bool disabled;
  List<String> types;
  String file;

  MediaGalleryEntries({this.id, this.mediaType, this.label, this.position, this.disabled, this.types, this.file});

  MediaGalleryEntries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaType = json['media_type'];
    label = json['label'];
    position = json['position'];
    disabled = json['disabled'];
    types = json['types'].cast<String>();
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media_type'] = this.mediaType;
    data['label'] = this.label;
    data['position'] = this.position;
    data['disabled'] = this.disabled;
    data['types'] = this.types;
    data['file'] = this.file;
    return data;
  }
}

class CustomAttributes {
  String attributeCode;
  String value;

  CustomAttributes({this.attributeCode, this.value});

  CustomAttributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_code'] = this.attributeCode;
    data['value'] = this.value;
    return data;
  }
}

class Values {
  int valueIndex;

  Values({this.valueIndex});

  Values.fromJson(Map<String, dynamic> json) {
    valueIndex = json['value_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_index'] = this.valueIndex;
    return data;
  }
}
