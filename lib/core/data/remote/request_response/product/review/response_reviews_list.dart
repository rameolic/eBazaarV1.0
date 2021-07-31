class ResponseReviewList {
  double avgRatingPercent;
  int count;
  List<Reviews> reviews;

  ResponseReviewList({this.avgRatingPercent, this.count, this.reviews});

  ResponseReviewList.fromJson(List<dynamic> array) {
    Map<String, dynamic> json = array[0];
    try {
      avgRatingPercent = json['avg_rating_percent'];
    }
    catch (e){
      int value = json['avg_rating_percent'];
      avgRatingPercent = value.toDouble();
    }
    count = json['count'];
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_rating_percent'] = this.avgRatingPercent;
    data['count'] = this.count;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String reviewId;
  String createdAt;
  String entityId;
  String entityPkValue;
  String statusId;
  String detailId;
  String title;
  String detail;
  String nickname;
  String customerId;
  String entityCode;
  List<RatingVotes> ratingVotes;

  Reviews({this.reviewId,
    this.createdAt,
    this.entityId,
    this.entityPkValue,
    this.statusId,
    this.detailId,
    this.title,
    this.detail,
    this.nickname,
    this.customerId,
    this.entityCode,
    this.ratingVotes});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    createdAt = json['created_at'];
    entityId = json['entity_id'];
    entityPkValue = json['entity_pk_value'];
    statusId = json['status_id'];
    detailId = json['detail_id'];
    title = json['title'];
    detail = json['detail'];
    nickname = json['nickname'];
    customerId = json['customer_id'];
    entityCode = json['entity_code'];
    if (json['rating_votes'] != null) {
      ratingVotes = new List<RatingVotes>();
      json['rating_votes'].forEach((v) {
        ratingVotes.add(new RatingVotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['created_at'] = this.createdAt;
    data['entity_id'] = this.entityId;
    data['entity_pk_value'] = this.entityPkValue;
    data['status_id'] = this.statusId;
    data['detail_id'] = this.detailId;
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['nickname'] = this.nickname;
    data['customer_id'] = this.customerId;
    data['entity_code'] = this.entityCode;
    if (this.ratingVotes != null) {
      data['rating_votes'] = this.ratingVotes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RatingVotes {
  String voteId;
  String optionId;
  String remoteIp;
  String remoteIpLong;
  String customerId;
  String entityPkValue;
  String ratingId;
  String reviewId;
  String percent;
  String value;
  String ratingCode;
  String storeId;

  RatingVotes({this.voteId,
    this.optionId,
    this.remoteIp,
    this.remoteIpLong,
    this.customerId,
    this.entityPkValue,
    this.ratingId,
    this.reviewId,
    this.percent,
    this.value,
    this.ratingCode,
    this.storeId});

  RatingVotes.fromJson(Map<String, dynamic> json) {
    voteId = json['vote_id'];
    optionId = json['option_id'];
    remoteIp = json['remote_ip'];
    remoteIpLong = json['remote_ip_long'];
    customerId = json['customer_id'];
    entityPkValue = json['entity_pk_value'];
    ratingId = json['rating_id'];
    reviewId = json['review_id'];
    percent = json['percent'];
    value = json['value'];
    ratingCode = json['rating_code'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_id'] = this.voteId;
    data['option_id'] = this.optionId;
    data['remote_ip'] = this.remoteIp;
    data['remote_ip_long'] = this.remoteIpLong;
    data['customer_id'] = this.customerId;
    data['entity_pk_value'] = this.entityPkValue;
    data['rating_id'] = this.ratingId;
    data['review_id'] = this.reviewId;
    data['percent'] = this.percent;
    data['value'] = this.value;
    data['rating_code'] = this.ratingCode;
    data['store_id'] = this.storeId;
    return data;
  }
}
