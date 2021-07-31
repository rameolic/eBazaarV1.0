import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/repository/product_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_to_cart_custom/add_to_cart_custom_request.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_to_cart_custom/add_to_cart_custom_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_cart_list.dart';
import 'package:thought_factory/core/data/remote/request_response/product/detail/product_detail_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/productResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/product/related_product/response_related_product.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/add_review_product/request_add_review.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/add_review_product/response_add_review.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/response_ratings_list.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/response_reviews_list.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_response.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/model/product_detail/model_product_detail.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

import 'base/base_notifier.dart';

class ProductDetailNotifier extends BaseNotifier {
  final log = getLogger('ProductDetailNotifier');
  final _repository = ProductRepository();
  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "product_detail_scaffold");

  List<RatingsListResponse> _listRatingResponse = List();
  List<ItemProduct> _lstRelatedProduct = List();
  ProductDetailModel _responseProductDetail =
      ProductDetailModel(lstProductUrl: List());
  ResponseReviewList _listReviewResponse = ResponseReviewList();
  ResponseAddReview _addReviewResponse = ResponseAddReview();
  AddReviewToProductRequest _addReviewToProductRequest =
      AddReviewToProductRequest();
  TextEditingController _reviewCommentTextController = TextEditingController();
  String productId, storeId;
  String _keyListViewRandom = "23423432";
  int _qty = 0;
  int _optionTypeId = -1;
  String _optionValue;
  int _currentSliderIndex = 0;
  WishListResponse _wishListResponse = WishListResponse();
  String _currencyCode = '';
  String adminToken = '';

  //TextEditingController _searchProductEditText = TextEditingController();
  //bool _btnCancelVisible = false;
  List<ItemProduct> _lstProducts = List();

  //constructor
  ProductDetailNotifier(BuildContext context, String skuName, int id) {
    super.context = context;
    //start required setup for view
    productId = id.toString();
    storeId = "1";
    //searchProductsEditText.addListener(searchController);
    CommonNotifier commonNotifier = CommonNotifier();
    if (commonNotifier != null && commonNotifier.cartListResponse != null) {
      updateCurrentProductQtyIfExist(
          commonNotifier.cartListResponse, productId);
    } else {
      log.d("common notifier is null");
    }
    initialApisToCall(id.toString(), skuName);
  }

  initialApisToCall(String id, String skuName) async {
    adminToken = await AppSharedPreference().getAdminToken();
    initialSetUp(skuName);

    callApiGetReviewList(id.toString());
    callApiRelatedProductList(id.toString());
  }

//  searchController() {
//    print("Second text field: ${searchProductsEditText.text}");
//    if (searchProductsEditText.text.length > 0) {
//      btnCancelVisible = true;
//      if (searchProductsEditText.text.length > 2) {
//        apiGetProductBySearchName(searchProductsEditText.text.trim());
//      }
//    } else {
//      btnCancelVisible = false;
//    }
//  }

  //initial setup for this notifier
  void initialSetUp(String skuName) async {
    currencyCode = await _getCurrencySymbol();
    String token = await AppSharedPreference().getAdminToken();
    await callApiGetProductDetail(token, skuName);
    callApiGetRatingsList();
  }

  WishListResponse get wishListResponse => _wishListResponse;

  set wishListResponse(WishListResponse value) {
    _wishListResponse = value;
    notifyListeners();
  }

  int get currentSliderIndex => _currentSliderIndex;

  set currentSliderIndex(int value) {
    _currentSliderIndex = value;
    //try{ notifyListeners(); } catch (e) {}
  }

  ProductDetailModel get responseProductDetail => _responseProductDetail;

  set responseProductDetail(ProductDetailModel value) {
    _responseProductDetail = value;
    notifyListeners();
  }

  List<RatingsListResponse> get listRatingsResponse => _listRatingResponse;

  set listRatingsResponse(List<RatingsListResponse> value) {
    _listRatingResponse = value;
    notifyListeners();
  }

  List<ItemProduct> get lstRelatedProduct => _lstRelatedProduct;

  set lstRelatedProduct(List<ItemProduct> value) {
    _lstRelatedProduct = value;
    notifyListeners();
  }

  ResponseReviewList get reviewListResponse => _listReviewResponse;

  set reviewListResponse(ResponseReviewList value) {
    _listReviewResponse = value;
    notifyListeners();
  }

  ResponseAddReview get addReviewResponse => _addReviewResponse;

  set addReviewResponse(ResponseAddReview value) {
    _addReviewResponse = value;
    notifyListeners();
  }

  TextEditingController get reviewCommentTextController =>
      _reviewCommentTextController;

  set reviewCommentTextController(TextEditingController value) {
    _reviewCommentTextController = value;
    notifyListeners();
  }

  AddReviewToProductRequest get addReviewToProductRequest =>
      _addReviewToProductRequest;

  set addReviewToProductRequest(AddReviewToProductRequest value) {
    _addReviewToProductRequest = value;
    notifyListeners();
  }

  String get keyListViewRandom => _keyListViewRandom;

  set keyListViewRandom(String value) {
    _keyListViewRandom = value;
    notifyListeners();
  }

  int get qty => _qty;

  set qty(int value) {
    _qty = value;
    notifyListeners();
  }

  int get optionTypeId => _optionTypeId;

  set optionTypeId(int value) {
    _optionTypeId = value;
    notifyListeners();
  }

  String get optionValue => _optionValue;

  set optionValue(String value) {
    _optionValue = value;
    notifyListeners();
  }

  String get currencyCode => _currencyCode;

  set currencyCode(String value) {
    _currencyCode = value;
    notifyListeners();
  }

//  TextEditingController get searchProductsEditText => _searchProductEditText;
//
//  set searchProductsEditText(TextEditingController value) {
//    _searchProductEditText = value;
//    //notifyListeners();
//  }
//
//  bool get btnCancelVisible => _btnCancelVisible;
//
//  set btnCancelVisible(bool value) {
//    _btnCancelVisible = value;
//    notifyListeners();
//  }

  List<ItemProduct> get lstProducts => _lstProducts;

  set lstProducts(List<ItemProduct> value) {
    _lstProducts = value;
    notifyListeners();
  }

  //api searchBar
  Future<List<ItemProduct>> apiGetProductBySearchName(
      String productName) async {
    log.i('api ::: apiGetProductBySearchName called');
    ProductResponse response =
        await _repository.getProductBySearchName(productName, adminToken);
    return onNewGetProductByCategoryIdResponse(response);
  }

  Future callApiGetProductDetail(String adminToken, String skuName) async {
    log.i('api ::: callApiGetProductDetail called');
    super.isLoading = true;
    if (skuName.isNotEmpty) {
      ProductDetailResponse response =
          await _repository.getProductDetailBySku(adminToken, skuName);
      onNewResponseOfGetProductDetail(response);
    } else {
      super.showSnackBarMessageParamASContext(
          context, 'SKU Name cant be empty from server');
    }
    super.isLoading = false;
  }

  Future<bool> callApiAddToCartCustomData(
      String adminToken, AddToCartCustomRequest addToCartCustomRequest) async {
    log.i('api ::: callApiAddToCartCustomData called');
    super.isLoading = true;
    try {
      AddToCartCustomResponse response = await _repository.addToCartCustomAPI(
          CommonNotifier().userToken, addToCartCustomRequest);
      if (response.status == AppConstants.RESPONSE_STATUS_SUCCESS) {
        CommonNotifier().callApiGetCartList();
        showMessage("Product added to cart successfully");
        super.isLoading = false;
      } else {
        showMessage(response.message);
        //super.showSnackBarMessageParamASContext(context, response.message);
      }
      super.isLoading = false;
    } catch (e) {
      log.e(e.toString());
      super.isLoading = false;
    }
    return false;
  }

//api add to wish list
  void callApiAddToWishList(ItemProduct itemProduct) async {
    log.i('api ::: callApiAddToWishList called');
    super.isLoading = true;
    await CommonNotifier().callApiAddToWishList(itemProduct.id.toString());
    itemProduct.isFavourite = true;
    super.isLoading = false;
  }

  //api remove item from wish list
  void callApiRemoveFromWishList(
      ItemProduct itemProduct, String wishListItemId) async {
    log.i('api ::: callApiRemoveFromWishList called');
    super.isLoading = true;
    await CommonNotifier().callApiRemoveFromWishList(wishListItemId ?? '0');
    itemProduct.isFavourite = false;
    super.isLoading = false;
  }

  Future callApiGetWishList() async {
    isLoading = true;
    WishListResponse response = await CommonNotifier().callApiGetWishList();
    onNewWishListResponse(response);
  }

  List<ItemProduct> onNewGetProductByCategoryIdResponse(
      ProductResponse response) {
    try {
      if (response != null &&
          response.items != null &&
          response.items.length > 0) {
        lstProducts.clear();

        response.items.forEach((item) {
          if (item.visibility == AppConstants.PRODUCT_VISIBILITY_SHOW &&
              item.typeId == AppConstants.PRODUCT_TYPE_SIMPLE &&
              item.status == 1) {
            ItemProduct itemProduct = ItemProduct(
                id: item.id,
                sku: item.sku,
                name: item.name,
                productType: item.typeId,
                price: (item.price.toDouble()) ?? 0,
                isCustomProduct:
                    (item.customAttributes.length > 0 ? true : false),
                imageUrl: super.getThumbnailImageUrlForProduct(item));
            CommonNotifier().matchProductId(item, itemProduct);
            if (item.customAttributes != null &&
                item.customAttributes.length > 0) {
              for (int i = 0; i < item.customAttributes.length; i++) {
                if ((item.customAttributes[i].attributeCode == "has_options") &&
                    (item.customAttributes[i].value == "1")) {
                  itemProduct.isCustomProduct = true;
                  break;
                } else {
                  itemProduct.isCustomProduct = false;
                }
              }
            }
            lstProducts.add(itemProduct);
          }
        });
        return lstProducts;
      } else {
        lstProducts.clear();
        return lstProducts;
      }
    } catch (exception) {
      log.e(
          'Error => onNewGetProductByCategoryIdResponse : ${exception.toString()}');
    }
  }

  void onNewWishListResponse(WishListResponse response) {
    if (response != null) {
      wishListResponse = response;
    }
  }

  void onNewResponseOfGetProductDetail(ProductDetailResponse response) {
    if (response != null) {
      List<ProductUrl> lstProductUrl;
      //add product image | video url list
      if (response.mediaGalleryEntries != null &&
          response.mediaGalleryEntries.length > 0) {
        lstProductUrl = List();
        response.mediaGalleryEntries.forEach((item) {
          ProductUrl productUrl = ProductUrl(
              url: AppUrl.baseImageUrl + item.file,
              isImageUrl: item.mediaType == AppConstants.GALLERY_TYPE_IMAGE
                  ? true
                  : false);
          lstProductUrl.add(productUrl);
        });
      }
      responseProductDetail.lstProductUrl = lstProductUrl;
      //add product name
      responseProductDetail.productName = response.name;
      responseProductDetail.sku = response.sku;

      //add product Fixed/Marked price
      responseProductDetail.productSalePrice = response.price.toDouble();
      //check is Special Price is found
      if (response.customAttributes != null &&
          response.customAttributes.length > 0) {
        for (int i = 0; i < response.customAttributes.length; i++) {
          // if Special Price found in Custom Attribute array
          if (response.customAttributes[i].attributeCode ==
                  AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_PRICE &&
              _isValidSpecialPrice(response, i)) {
            // && _isValidSpecialPrice(response, i)
            responseProductDetail.isSpecialPriceFound = true;
            if (responseProductDetail.isSpecialPriceFound == true) {
              responseProductDetail.productSalePrice =
                  double.parse(response.customAttributes[i].value ?? 0.0);
              responseProductDetail.productMarkedPrice =
                  response.price.toDouble();
              responseProductDetail.discountPercent = getDiscountPercentage(
                  responseProductDetail.productMarkedPrice,
                  responseProductDetail.productSalePrice);
            }
          } else {
            responseProductDetail.isSpecialPriceFound = false;
          }
          // if Description found
          if (response.customAttributes[i].attributeCode == 'description' &&
              response.customAttributes[i].value != null) {
            responseProductDetail.description =
                response.customAttributes[i].value;
          }

          // if shareUrl found
          if (response.customAttributes[i].attributeCode == 'url_key' &&
              response.customAttributes[i].value != null) {
            responseProductDetail.isUrlFound = true;
            responseProductDetail.shareProductUrl =
                response.customAttributes[i].value;
          }
        }
      }
      //check Product Options Data Available
      responseProductDetail.isOptionsAvailable =
          (response.options != null && response.options.length > 0)
              ? true
              : false;
      //add options fields data
      if (responseProductDetail.isOptionsAvailable) {
        //add options[0] title
        responseProductDetail.optionTitle = response.options[0].title;
        //check values are available
        responseProductDetail.isOptionsValuesAvailable =
            (response.options[0].values != null &&
                    response.options[0].values.length > 0)
                ? true
                : false;
        //add options[0] -> values array of value
        responseProductDetail.option_id =
            response.options[0].optionId.toString();
        if (responseProductDetail.isOptionsValuesAvailable) {
          responseProductDetail.optionsValues = response.options[0].values;
          responseProductDetail.lstOptionsSelected = List();
          response.options[0].values.forEach((element) {
            responseProductDetail.lstOptionsSelected.add(false);
          });
        }
      }
    } else {
      super.showSnackBarMessageParamASContext(
          context, 'response is NULL from server ');
    }
  }

  void callApiGetRatingsList() async {
    log.i('api ::: GetRatingList called');
    listRatingsResponse =
        await _repository.getRatingsList("1"); // here 1 is storeId
    listRatingsResponse.add(RatingsListResponse(
        entityId: "1",
        isActive: "true",
        position: "0",
        ratingCode: "Rating",
        ratingId: "1",
        storeId: "1"));
    log.d(">>>>>>>>>>>" + _listRatingResponse.toString());
    responseProductDetail.listRatingList = listRatingsResponse;

    addReviewToProductRequest.nickname =
        CommonNotifier().userDetail.firstname ?? "User";
    addReviewToProductRequest.title = _reviewCommentTextController.text;
    addReviewToProductRequest.detail = _reviewCommentTextController.text;
    addReviewToProductRequest.productId = productId;
    addReviewToProductRequest.storeId = storeId;
    addReviewToProductRequest.ratingData = List();
    for (int i = 0; i < listRatingsResponse.length; i++) {
      RatingData _data = RatingData();
      _data.ratingValue = "4";
      _data.ratingCode = listRatingsResponse[i].ratingCode;
      _data.ratingId = listRatingsResponse[i].ratingId;
      addReviewToProductRequest.ratingData.add(_data);
    }
  }

  void callApiGetReviewList(String productId) async {
    log.i('api ::: GetUserReviewList called');
    super.isLoading = true;
    reviewListResponse = await _repository.getProductReviewList(productId);
    log.d(">>>>>>>>>>>" + reviewListResponse.toString());
    if (reviewListResponse != null &&
        reviewListResponse.avgRatingPercent != null) {
      responseProductDetail.avgRatingPercent =
          reviewListResponse.avgRatingPercent;
      responseProductDetail.reviewsList = reviewListResponse.reviews;
    }

    super.isLoading = false;
  }

  void callApiRelatedProductList(String productId) async {
    log.i('api ::: GetRelatedProductList called');
    super.isLoading = true;
    RelatedProductResponse lstRelatedProductResponse =
        await _repository.getRelatedProducts(productId);
    log.i("Related Product data is : " +
        lstRelatedProductResponse.toJson().toString());
    onNewResponseOfGetRelatedProducts(lstRelatedProductResponse);
    super.isLoading = false;
  }

  void onNewResponseOfGetRelatedProducts(RelatedProductResponse response) {
    //clear old records if exists
    if (lstRelatedProduct.isNotEmpty) lstRelatedProduct.clear();

    if (response != null &&
        response.status == AppConstants.RESPONSE_STATUS_SUCCESS &&
        response.data != null &&
        response.data.length > 0) {
      lstRelatedProduct = response.data
          .map((product) => ItemProduct(
              name: product.name,
              price: double.parse(product.price) ?? 0.00,
              imageUrl: AppUrl.baseImageUrl + product.productImage ?? "",
              productType: product.productType ?? "",
              sku: product.sku,
              maxQuantity: product.productQtyStock))
          .toList();
    }
    /*else {
     super.showSnackBarMessageParamASContext(context,response.message);
    }*/
  }

  void callApiAddReview(
      AddReviewToProductRequest addReviewToProductRequest) async {
    log.i('api ::: AddReview called');
    super.isLoading = true;
    addReviewResponse =
        await _repository.apiAddProductReview(addReviewToProductRequest);
    super.isLoading = false;
    if (addReviewResponse != null && addReviewResponse.message.length > 0) {
      final snackBar = new SnackBar(
        content: new Text(addReviewResponse.message),
        duration: Duration(seconds: 3),
      );
      scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  double getDiscountPercentage(
      double productMarkedPrice, double productSalePrice) {
    double discount = (productMarkedPrice != null ? productMarkedPrice : 0) -
        (productSalePrice != null ? productSalePrice : 0);
    double disPercentage = (discount / productMarkedPrice) * 100;
    return disPercentage;
  }

  bool _isValidSpecialPrice(ProductDetailResponse response, int position) {
    if (response.customAttributes[position].attributeCode ==
        AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_PRICE) {
      String fromDate = "";
      String toDate = "";
      for (int index = 0; index < response.customAttributes.length; index++) {
        if (response.customAttributes[index].attributeCode ==
            AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_FROM_DATE) {
          fromDate = response.customAttributes[index].value;
        }

        if (response.customAttributes[index].attributeCode ==
            AppConstants.CUSTOM_ATTRIBUTE_SPECIAL_TO_DATE) {
          toDate = response.customAttributes[index].value;
        }
      }
      if (fromDate.isNotEmpty && toDate.isNotEmpty) {
        return _isDateExpired(fromDate, toDate);
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool _isDateExpired(String fromDateInString, String toDateInString) {
    try {
      DateTime fromDate, toDate, currentDate;
      DateFormat dateFormat =
          DateFormat("yyyy-MM-dd hh:mm:ss"); // 2019-09-12 00:00:00
      fromDate = dateFormat.parse(fromDateInString);
      toDate = dateFormat.parse(toDateInString);
      currentDate = DateTime.now();

      log.d(
          "differ From " + fromDate.difference(currentDate).inDays.toString());
      log.d("differ To " + toDate.difference(currentDate).inDays.toString());
      log.d("differ current " + toDate.day.toString());

      if (currentDate.isAfter(fromDate) &&
          (currentDate.isBefore(toDate) ||
              toDate.difference(currentDate).inDays == 0)) {
        log.d("differ : Offer available");
        return true;
      } else {
        log.d("differ : Offer Expired");
        return false;
      }
    } catch (e) {
      log.e("Error " + e.toString());
      return false;
    }
  }

  Future<String> _getCurrencySymbol() async {
    return AppSharedPreference()
        .getPreferenceData(AppConstants.KEY_CURRENCY_CODE);
  }

  showMessage(String content) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(content)));
  }

  void updateCurrentProductQtyIfExist(
      CartListResponse cartListResponse, String productId) {
    qty = 0;
    if (cartListResponse.data != null && cartListResponse.data.length > 0) {
      for (int i = 0; i < cartListResponse.data.length; i++) {
        if (cartListResponse.data[i].productList != null &&
            cartListResponse.data[i].productList.length > 0) {
          for (int j = 0;
              j < cartListResponse.data[i].productList.length;
              j++) {
            if (productId ==
                    cartListResponse.data[i].productList[j].productId ??
                "") {
              qty = cartListResponse.data[i].productList[j].productQty;
              break;
            }
          }
        }
      }
    }
  }
}
