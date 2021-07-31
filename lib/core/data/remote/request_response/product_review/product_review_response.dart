class ProductReviewDetailResponse {
  List<ProductReviewItem> data;
  String message;
  String status;

  ProductReviewDetailResponse({this.data, this.message, this.status});

  ProductReviewDetailResponse.fromJson(List<dynamic> response) {
    if (response != null) {
      Map<String, dynamic> json = response[0];
      if (json['data'] != null) {
        data = new List<ProductReviewItem>();
        json['data'].forEach((v) {
          data.add(new ProductReviewItem.fromJson(v));
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
}

class ProductReviewItem {
  String sku;
  String productId;
  String name;
  String productType;
  String productImage;
  String nickname;
  String detail;
  String title;
  String hasOptions;
  String reviewId;
  String productRating;
  String ratingPercent;
  String optionId;
  String entityPkValue;
  String statusId;
  String attributeSetId;
  String createdAt;
  String updatedAt;
  String reviewCreatedAt;
  List<RatingDetails> ratingDetails;

  ProductReviewItem(
      {this.sku,
        this.productId,
        this.name,
        this.productType,
        this.productImage,
        this.nickname,
        this.detail,
        this.title,
        this.hasOptions,
        this.reviewId,
        this.productRating,
        this.ratingPercent,
        this.optionId,
        this.entityPkValue,
        this.statusId,
        this.attributeSetId,
        this.createdAt,
        this.updatedAt,
        this.reviewCreatedAt,
        this.ratingDetails});

  ProductReviewItem.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    productId = json['product_id'];
    name = json['name'];
    productType = json['product_type'];
    productImage = json['product_image'];
    nickname = json['nickname'];
    detail = json['detail'];
    title = json['title'];
    hasOptions = json['has_options'];
    reviewId = json['review_id'];
    productRating = json['product_rating'];
    ratingPercent = json['rating_percent'];
    optionId = json['option_id'];
    entityPkValue = json['entity_pk_value'];
    statusId = json['status_id'];
    attributeSetId = json['attribute_set_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reviewCreatedAt = json['review_created_at'];
    if (json['rating_details'] != null) {
      ratingDetails = new List<RatingDetails>();
      json['rating_details'].forEach((v) {
        ratingDetails.add(new RatingDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['product_type'] = this.productType;
    data['product_image'] = this.productImage;
    data['nickname'] = this.nickname;
    data['detail'] = this.detail;
    data['title'] = this.title;
    data['has_options'] = this.hasOptions;
    data['review_id'] = this.reviewId;
    data['product_rating'] = this.productRating;
    data['rating_percent'] = this.ratingPercent;
    data['option_id'] = this.optionId;
    data['entity_pk_value'] = this.entityPkValue;
    data['status_id'] = this.statusId;
    data['attribute_set_id'] = this.attributeSetId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['review_created_at'] = this.reviewCreatedAt;
    if (this.ratingDetails != null) {
      data['rating_details'] =
          this.ratingDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatingDetails {
  String ratingId;
  String ratingCode;
  String value;
  String percent;

  RatingDetails({this.ratingId, this.ratingCode, this.value, this.percent});

  RatingDetails.fromJson(Map<String, dynamic> json) {
    ratingId = json['rating_id'];
    ratingCode = json['rating_code'];
    value = json['value'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating_id'] = this.ratingId;
    data['rating_code'] = this.ratingCode;
    data['value'] = this.value;
    data['percent'] = this.percent;
    return data;
  }
}