import 'package:flutter/cupertino.dart';
import 'package:thought_factory/core/data/remote/repository/product_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/product_review/product_review_response.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';

import 'common_notifier.dart';

class ProductReviewNotifier extends BaseNotifier {
  List<ProductReviewItem> _productReviewList = List();

  List<ProductReviewItem> get productReviewList => _productReviewList;

  String _message = "";

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  set productReviewList(List<ProductReviewItem> value) {
    _productReviewList = value;
    notifyListeners();
  }

  final _productRepository = ProductRepository();

  ProductReviewNotifier(BuildContext context) {
    super.context = context;
    setData();
  }

  Future setData() async {
    super.isLoading = true;
    await _productRepository
        .apiProductReviewDetail(CommonNotifier().userToken)
        .then((value) {
      if (value != null) {
        _onProductReviewDetailResponse(value);
      }
    });
    super.isLoading = false;
  }

  void _onProductReviewDetailResponse(ProductReviewDetailResponse value) {
    if (value.status == "1" && value.data.length > 0) {
      productReviewList.clear();
      productReviewList = value.data;
    } else {
      _message = value.message;
      _productReviewList.clear();
    }
  }
}
