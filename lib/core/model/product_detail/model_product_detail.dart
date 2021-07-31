import 'package:thought_factory/core/data/remote/request_response/product/detail/product_detail_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/response_reviews_list.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/response_ratings_list.dart';


class ProductDetailModel {
  String productName;
  String sku;
  String option_id;
  List<ProductUrl> lstProductUrl;
  double productMarkedPrice = 0;
  bool isSpecialPriceFound = false;
  double productSalePrice = 0;
  double discountPercent = 0;
  double avgRatingPercent;
  bool isOptionsAvailable = false;
  bool isUrlFound = false;
  String shareProductUrl = "";
  String optionTitle;
  bool isOptionsValuesAvailable = false;
  List<ValuesOptions> optionsValues;
  List<bool> lstOptionsSelected = List();
  int optionSelected = 0;
  String description;
  List<Reviews> reviewsList;
  List<RatingsListResponse> listRatingList;

  ProductDetailModel({
    this.productName,
    this.lstProductUrl,
    this.productMarkedPrice,
    this.productSalePrice,
    this.discountPercent,
    this.avgRatingPercent,
    this.isOptionsAvailable,
    this.optionTitle,
    this.isOptionsValuesAvailable,
    this.optionsValues,
    this.lstOptionsSelected,
    this.optionSelected,
    this.description,
    this.reviewsList,
    this.listRatingList,
  });
}

class ProductUrl {
  String url;
  bool isImageUrl; //can be image or video

  ProductUrl({this.url, this.isImageUrl});
}
