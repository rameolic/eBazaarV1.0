class RatingsListResponse {
  String ratingId;
  String entityId;
  String ratingCode;
  String position;
  String isActive;
  String storeId;

  RatingsListResponse(
      {this.ratingId,
        this.entityId,
        this.ratingCode,
        this.position,
        this.isActive,
        this.storeId});

  RatingsListResponse.fromJson(List<dynamic> array, int index) {
    Map<String, dynamic> json = array[index];
    ratingId = json['rating_id'];
    entityId = json['entity_id'];
    ratingCode = json['rating_code'];
    position = json['position'];
    isActive = json['is_active'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating_id'] = this.ratingId;
    data['entity_id'] = this.entityId;
    data['rating_code'] = this.ratingCode;
    data['position'] = this.position;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    return data;
  }
}