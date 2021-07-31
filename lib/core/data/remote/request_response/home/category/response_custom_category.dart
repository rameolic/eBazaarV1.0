class ResponseCustomCategory {
  List<ItemCategory> data;
  String message;
  int status;

  ResponseCustomCategory({this.data, this.message, this.status});

  ResponseCustomCategory.fromJson(List<dynamic> json) {
    Map<String, dynamic> mapJson = json[0];
    if (mapJson['data'] != null) {
      data = new List<ItemCategory>();
      mapJson['data'].forEach((v) {
        data.add(new ItemCategory.fromJson(v));
      });
    }
    message = mapJson['message'];
    status = mapJson['status'];
  }

  ResponseCustomCategory.fromErrorJson(Map<String, dynamic> json) {
    message = json['message'];
    status = 0;
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

class ItemCategory {
  String entityId;
  String attributeSetId;
  String parentId;
  String createdAt;
  String updatedAt;
  String path;
  String position;
  String level;
  String childrenCount;
  String isActive;
  String description;
  String metaKeywords;
  String metaDescription;
  String customLayoutUpdate;
  String landingPage;
  String isAnchor;
  String includeInMenu;
  String customUseParentSettings;
  String customApplyToProducts;
  String name;
  String image;
  String metaTitle;
  String displayMode;
  String customDesign;
  String pageLayout;
  String urlKey;
  String urlPath;
  String customDesignFrom;
  String customDesignTo;
  String imagePath;
  String imageIconPath;

  ItemCategory(
      {this.entityId,
      this.attributeSetId,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.path,
      this.position,
      this.level,
      this.childrenCount,
      this.isActive,
      this.description,
      this.metaKeywords,
      this.metaDescription,
      this.customLayoutUpdate,
      this.landingPage,
      this.isAnchor,
      this.includeInMenu,
      this.customUseParentSettings,
      this.customApplyToProducts,
      this.name,
      this.image,
      this.metaTitle,
      this.displayMode,
      this.customDesign,
      this.pageLayout,
      this.urlKey,
      this.urlPath,
      this.customDesignFrom,
      this.customDesignTo,
      this.imagePath,
      this.imageIconPath});

  ItemCategory.fromJson(Map<String, dynamic> json) {
    entityId = _convertToNonNullValue(json['entity_id'].toString());
    attributeSetId = _convertToNonNullValue(json['attribute_set_id'].toString());
    parentId = _convertToNonNullValue(json['parent_id'].toString());
    createdAt = _convertToNonNullValue(json['created_at'].toString());
    updatedAt = _convertToNonNullValue(json['updated_at'].toString());
    path = _convertToNonNullValue(json['path'].toString());
    position = _convertToNonNullValue(json['position'].toString());
    level = _convertToNonNullValue(json['level'].toString());
    childrenCount = _convertToNonNullValue(json['children_count'].toString());
    isActive = _convertToNonNullValue(json['is_active'].toString());
    description = _convertToNonNullValue(json['description'].toString());
    metaKeywords = _convertToNonNullValue(json['meta_keywords'].toString());
    metaDescription = _convertToNonNullValue(json['meta_description'].toString());
    customLayoutUpdate = _convertToNonNullValue(json['custom_layout_update'].toString());
    landingPage = _convertToNonNullValue(json['landing_page'].toString());
    isAnchor = _convertToNonNullValue(json['is_anchor'].toString());
    includeInMenu = _convertToNonNullValue(json['include_in_menu'].toString());
    customUseParentSettings = _convertToNonNullValue(json['custom_use_parent_settings'].toString());
    customApplyToProducts = _convertToNonNullValue(json['custom_apply_to_products'].toString());
    name = _convertToNonNullValue(json['name'].toString());
    image = _convertToNonNullValue(json['image'].toString());
    metaTitle = _convertToNonNullValue(json['meta_title'].toString());
    displayMode = _convertToNonNullValue(json['display_mode'].toString());
    customDesign = _convertToNonNullValue(json['custom_design'].toString());
    pageLayout = _convertToNonNullValue(json['page_layout'].toString());
    urlKey = _convertToNonNullValue(json['url_key'].toString());
    urlPath = _convertToNonNullValue(json['url_path'].toString());
    customDesignFrom = _convertToNonNullValue(json['custom_design_from'].toString());
    customDesignTo = _convertToNonNullValue(json['custom_design_to'].toString());
    imagePath = _convertToNonNullValue(json['image_path'].toString());
    imageIconPath = _convertToNonNullValue(json['image_icon_path'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity_id'] = this.entityId;
    data['attribute_set_id'] = this.attributeSetId;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['path'] = this.path;
    data['position'] = this.position;
    data['level'] = this.level;
    data['children_count'] = this.childrenCount;
    data['is_active'] = this.isActive;
    data['description'] = this.description;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['custom_layout_update'] = this.customLayoutUpdate;
    data['landing_page'] = this.landingPage;
    data['is_anchor'] = this.isAnchor;
    data['include_in_menu'] = this.includeInMenu;
    data['custom_use_parent_settings'] = this.customUseParentSettings;
    data['custom_apply_to_products'] = this.customApplyToProducts;
    data['name'] = this.name;
    data['image'] = this.image;
    data['meta_title'] = this.metaTitle;
    data['display_mode'] = this.displayMode;
    data['custom_design'] = this.customDesign;
    data['page_layout'] = this.pageLayout;
    data['url_key'] = this.urlKey;
    data['url_path'] = this.urlPath;
    data['custom_design_from'] = this.customDesignFrom;
    data['custom_design_to'] = this.customDesignTo;
    data['image_path'] = this.imagePath;
    data['image_icon_path'] = this.imageIconPath;
    return data;
  }

  _convertToNonNullValue(String content) {
    return content != null ? content : "";
  }
}
