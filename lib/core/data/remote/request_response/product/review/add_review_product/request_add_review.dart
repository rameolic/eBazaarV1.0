import 'package:flutter/material.dart';

class AddReviewToProductRequest {
  String productId;
  String nickname;
  String title;
  String detail;
  List<RatingData> ratingData;
  String storeId;

  AddReviewToProductRequest({this.productId, this.nickname, this.title, this.detail, this.ratingData, this.storeId});

  AddReviewToProductRequest.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    nickname = json['nickname'];
    title = json['title'];
    detail = json['detail'];
    if (json['ratingData'] != null) {
      ratingData = new List<RatingData>();
      json['ratingData'].forEach((v) {
        ratingData.add(new RatingData.fromJson(v));
      });
    }
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['nickname'] = this.nickname;
    data['title'] = this.title;
    data['detail'] = this.detail;
    if (this.ratingData != null) {
      data['ratingData'] = this.ratingData.map((v) => v.toJson()).toList();
    }
    data['storeId'] = this.storeId;
    return data;
  }
}

class RatingData extends ChangeNotifier {
  String ratingId;
  String ratingCode;
  String ratingValue;

  RatingData({this.ratingId, this.ratingCode, this.ratingValue});

  RatingData.fromJson(Map<String, dynamic> json) {
    ratingId = json['rating_id'];
    ratingCode = json['ratingCode'];
    ratingValue = json['ratingValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating_id'] = this.ratingId;
    data['ratingCode'] = this.ratingCode;
    data['ratingValue'] = this.ratingValue;
    return data;
  }
}
