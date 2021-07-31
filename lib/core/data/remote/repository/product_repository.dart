import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_to_cart_custom/add_to_cart_custom_request.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_to_cart_custom/add_to_cart_custom_response.dart';
import 'package:thought_factory/core/data/remote/request_response/compare/add_or_remove_products_to_compare_response.dart';
import 'package:thought_factory/core/data/remote/request_response/compare/compare_product_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/error_response.dart';
import 'package:thought_factory/core/data/remote/request_response/home/category/response_custom_category.dart';
import 'package:thought_factory/core/data/remote/request_response/home/distributor/response_top_distributor.dart';
import 'package:thought_factory/core/data/remote/request_response/product/detail/product_detail_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/filter/response_filter.dart';
import 'package:thought_factory/core/data/remote/request_response/product/popular_product/PopularProductsResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/product/productResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/product/related_product/response_related_product.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/add_review_product/request_add_review.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/add_review_product/response_add_review.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/response_ratings_list.dart';
import 'package:thought_factory/core/data/remote/request_response/product/review/response_reviews_list.dart';
import 'package:thought_factory/core/data/remote/request_response/product_review/product_review_response.dart';
import 'package:thought_factory/router.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_repository.dart';

class ProductRepository extends BaseRepository {
  ProductRepository._internal();

  static final ProductRepository _singleInstance =
      ProductRepository._internal();

  factory ProductRepository() => _singleInstance;

  //api: load filters based on Category (POST)

  Future getFiltersCategory(String categoryID) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathFilterList,
          method: Method.POST,
          encoding: Encoding.getByName("utf-8"),
          headers: headerContentTypeAndAccept,
          body: {"categoryId": categoryID});
      if (response.statusCode == HttpStatus.ok) {
        return FilterResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.notFound) {
        return FilterResponse.fromErrorJson(json.decode(response.body));
      } else {
        return null;
      }
    } else {
      return FilterResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

  //api: get all category list
  Future getCustomProductCategories(String adminToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          headers: buildHeaderWithAdminToken(adminToken: adminToken),
          method: Method.GET,
          pathUrl: AppUrl.pathCategoryCustomList);
      if (response.statusCode == HttpStatus.ok) {
        return ResponseCustomCategory.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.notFound) {
        return ResponseCustomCategory.fromErrorJson(json.decode(response.body));
      } else {
        return null;
        //throw Exception('failed to load post');
      }
    } else {
      return ResponseCustomCategory(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

  //api: get top distributor list
  Future getTopDistributorList() async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.GET, pathUrl: AppUrl.pathTopDistributorList);
      if (response.statusCode == HttpStatus.ok) {
        return ResponseTopDistributor.fromJson(json.decode(response.body));
      } else if (response.statuscode == HttpStatus.unauthorized) {
        ErrorResponse errorResponse =
            ErrorResponse.fromJson(json.decode(response.body));
        return ResponseTopDistributor(
            status: 0, message: errorResponse.message, data: null);
      } else if (response.statusCode == HttpStatus.notFound) {
        return ResponseTopDistributor.fromErrorJson(json.decode(response.body));
      } else {
        return null;
        //throw Exception('failed to load post');
      }
    } else {
      return ResponseTopDistributor(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

  //api: get popular products list
  Future<PopularProductsResponse> getPopularProductsList(
      {String adminToken}) async {
    log.d("Admin Token : $adminToken");
    final response = await networkProvider.call(
        headers: buildHeaderWithAdminToken(adminToken: adminToken),
        method: Method.GET,
        pathUrl: AppUrl.pathPopularProducts);
    if (response.statusCode == HttpStatus.ok) {
      return PopularProductsResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.notFound) {
      return null;
    } else {
      return null;
      //throw Exception('failed to load post');
    }
  }

  //api: get all products for category
  Future<ProductResponse> getProductListByCategory(
      int nCategoryId, String adminToken) async {
    final response = await networkProvider.call(
        method: Method.GET,
        pathUrl: AppUrl.pathProductsSearch,
        headers: buildHeaderWithAdminToken(adminToken: adminToken),
        queryParam: {
          'searchCriteria[filterGroups][0][filters][0][field]':
              AppConstants.FIELD_CATEGORY_ID,
          'searchCriteria[filterGroups][0][filters][0][value]': '$nCategoryId',
          'searchCriteria[filterGroups][0][filters][0][conditionType]':
              AppConstants.CONDITION_TYPE_EQUAL,
          'searchCriteria[sortOrders][0][field]': AppConstants.FIELD_CREATED_AT,
          'searchCriteria[sortOrders][0][direction]':
              AppConstants.DIRECTION_DESCENDING,
          'searchCriteria[pageSize]': '1000',
          'searchCriteria[currentPage]': '1',
        });

    if (response.statusCode == HttpStatus.ok) {
      return ProductResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //api: get filtered products for category
  Future<ProductResponse> getProductListByCategoryFiltered(
      Map<String, String> stringParams, String adminToken) async {
    final response = await networkProvider.call(
        method: Method.GET,
        pathUrl: AppUrl.pathProductsSearch,
        headers: buildHeaderWithAdminToken(adminToken: adminToken),
        queryParam: stringParams);

    if (response.statusCode == HttpStatus.ok) {
      return ProductResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //api: get related products for given Name
  Future<ProductResponse> getProductBySearchName(
      String productName, String adminToken) async {
    productName = '%${productName.trim()}%';

    final response = await networkProvider.call(
        method: Method.GET,
        pathUrl: AppUrl.pathProductsSearch,
        headers: buildHeaderWithAdminToken(adminToken: adminToken),
        queryParam: {
          'searchCriteria[filterGroups][0][filters][0][field]':
              AppConstants.FIELD_NAME,
          'searchCriteria[filterGroups][0][filters][0][value]': '$productName',
          'searchCriteria[filterGroups][0][filters][0][conditionType]':
              AppConstants.CONDITION_TYPE_LIKE,
          'searchCriteria[sortOrders][0][field]': AppConstants.FIELD_CREATED_AT,
          'searchCriteria[sortOrders][0][direction]':
              AppConstants.DIRECTION_DESCENDING,
          'searchCriteria[pageSize]': '40',
          'searchCriteria[currentPage]': '1',
        });

    if (response.statusCode == HttpStatus.ok) {
      return ProductResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //api: get related products for given Name in Distributor wise
  Future<ProductResponse> getProductBySearchNameDistributorWise(
      String sellerId, String productName) async {
    productName = '%${productName.trim()}%';
    final response = await networkProvider.call(
        method: Method.GET,
        pathUrl: AppUrl.pathProductsSearch,
        headers: mapAuthHeader,
        queryParam: {
          'searchCriteria[sortOrders][0][field]': 'created_at',
          'searchCriteria[filter_groups][0][filters][0][field]': 'seller_id',
          'searchCriteria[filter_groups][0][filters][0][value]': sellerId,
          'searchCriteria[filter_groups][0][filters][0][condition_type]': 'eq',
          'searchCriteria[filter_groups][1][filters][0][field]':
              AppConstants.FIELD_NAME,
          'searchCriteria[filter_groups][1][filters][0][value]': '$productName',
          'searchCriteria[filter_groups][1][filters][0][conditionType]':
              AppConstants.CONDITION_TYPE_LIKE,
          'searchCriteria[sortOrders][0][field]': AppConstants.FIELD_CREATED_AT,
          'searchCriteria[sortOrders][0][direction]':
              AppConstants.DIRECTION_DESCENDING,
          'searchCriteria[pageSize]': '40',
          'searchCriteria[currentPage]': '1',
        });

    if (response.statusCode == HttpStatus.ok) {
      return ProductResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  // api: get all Top Distributor items
  Future<ProductResponse> getProductListBySellerID(
      int sellerId, String adminToken) async {
    final response = await networkProvider.call(
        method: Method.GET,
        pathUrl: AppUrl.pathProductsSearch,
        headers: buildHeaderWithAdminToken(adminToken: adminToken),
        queryParam: {
          'searchCriteria[filterGroups][0][filters][0][field]':
              AppConstants.FIELD_SELLER_ID,
          'searchCriteria[filterGroups][0][filters][0][value]': '$sellerId',
          'searchCriteria[filterGroups][0][filters][0][conditionType]':
              AppConstants.CONDITION_TYPE_EQUAL,
          'searchCriteria[sortOrders][0][field]': AppConstants.FIELD_CREATED_AT,
          'searchCriteria[sortOrders][0][direction]':
              AppConstants.DIRECTION_DESCENDING,
          'searchCriteria[pageSize]': '50',
          'searchCriteria[currentPage]': '1',
        });

    if (response.statusCode == HttpStatus.ok) {
      return ProductResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<ProductDetailResponse> getProductDetailBySku(
      String adminToken, String skuName) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.GET,
          headers: super.buildDefaultHeaderWithToken(adminToken),
          pathUrl: '${AppUrl.pathProductsSearch}/$skuName');

      if (response.statusCode == HttpStatus.ok) {
        return ProductDetailResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.badRequest) {
        return ProductDetailResponse.fromErrorJson(json.decode(response.body));
      } else {
        return null;
        //throw Exception('failed to load post');
      }
    } else {
      return ProductDetailResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

  Future<AddToCartCustomResponse> addToCartCustomAPI(
      String adminToken, AddToCartCustomRequest request) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          headers: super.buildDefaultHeaderWithToken(adminToken),
          pathUrl: '${AppUrl.pathAddToCartCustom}',
          body: request.toJson());
      if (response.statusCode == HttpStatus.ok) {
        return AddToCartCustomResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.badRequest) {
        return AddToCartCustomResponse.fromErrorJson(
            json.decode(response.body));
      } else {
        return null;
        //throw Exception('failed to load post');
      }
    } else {
      //return (message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
      return null;
    }
  }

  //api: get Ratings List
  Future<List<RatingsListResponse>> getRatingsList(String storeId) async {
    final response = await networkProvider.call(
      method: Method.GET,
      pathUrl: AppUrl.pathRatingList + storeId.trim(),
    );

    if (response.statusCode == HttpStatus.ok) {
      List<RatingsListResponse> ratingsList = List();
      if (response.body != null) {
        List<dynamic> list = json.decode(response.body);
        for (int i = 0; i < list.length; i++) {
          ratingsList
              .add(RatingsListResponse.fromJson(json.decode(response.body), i));
        }
      } else {
        return null;
      }
      return ratingsList;
    } else {
      return null;
    }
  }

  //api: getProductReview by productId
  Future<ResponseReviewList> getProductReviewList(String productId) async {
    final response = await networkProvider.call(
      method: Method.GET,
      pathUrl: AppUrl.pathProductReviewList + productId.trim(),
    );
    if (response.statusCode == HttpStatus.ok) {
      return ResponseReviewList.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //api: getAddReview
  Future<ResponseAddReview> apiAddProductReview(
      AddReviewToProductRequest addReviewToProductRequest) async {
    String token = await AppSharedPreference().getUserToken();
    final response = await networkProvider.call(
        method: Method.POST,
        pathUrl: AppUrl.pathAddReviewToProduct,
        headers: buildDefaultHeaderWithToken(token),
        body: addReviewToProductRequest.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return ResponseAddReview.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.badRequest) {
      return ResponseAddReview.fromErrorJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //api: getRelated Products
  Future<RelatedProductResponse> getRelatedProducts(String productId) async {
    String token = await AppSharedPreference().getAdminToken();
    CompareProductListResponse compareProductListResponse =
        CompareProductListResponse();
    final response = await networkProvider.call(
      method: Method.POST,
      pathUrl: AppUrl.pathRelatedProduct,
      encoding: Encoding.getByName("utf-8"),
      body: {"product_id": productId},
      headers: buildDefaultHeaderWithToken(token),
    );
    if (response.statusCode == HttpStatus.ok) {
      if (response.body != null) {
        return RelatedProductResponse.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //api: add Products to compare
  Future<AddOrRemoveProductsToCompareResponse> addProductsToCompare(
      String productId, String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    List<AddToCompare> addRemoveResponse = List();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
        method: Method.POST,
        pathUrl: AppUrl.pathAddProductsToCompare,
        encoding: Encoding.getByName("utf-8"),
        body: {"product_id": productId},
        headers: buildDefaultHeaderWithToken(userToken),
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.body != null) {
          return AddOrRemoveProductsToCompareResponse.fromJson(
              json.decode(response.body));
        } else {
          return AddOrRemoveProductsToCompareResponse.fromJson1(
              json.decode(response.body));
        }
      } else {
        return AddOrRemoveProductsToCompareResponse.fromJson1(
            json.decode(response.body));
      }
    } else {
      addRemoveResponse.add(AddToCompare(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: -1));
      return AddOrRemoveProductsToCompareResponse(
          addToCompare: addRemoveResponse);
    }
  }

  // api: fetch compare product list
  Future<CompareProductListResponse> fetchCompareProducts(
      String userToken) async {
    final response = await networkProvider.call(
        pathUrl: AppUrl.pathProductCompareList,
        method: Method.GET,
        headers: buildOnlyHeaderWithToken(userToken));

    if (response.statusCode == HttpStatus.ok) {
      return CompareProductListResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //api: add Products to compare
  Future<AddOrRemoveProductsToCompareResponse> removeProductsToCompare(
      String productId1, String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    List<AddToCompare> addRemoveResponse = List();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
        method: Method.DELETE,
        pathUrl: AppUrl.pathRemoveProductsFromCompare + productId1,
        encoding: Encoding.getByName("utf-8"),
        headers: buildDefaultHeaderWithToken(userToken),
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.body != null) {
          return AddOrRemoveProductsToCompareResponse.fromJson(
              json.decode(response.body));
        } else {
          return AddOrRemoveProductsToCompareResponse.fromJson1(
              json.decode(response.body));
        }
      } else {
        return AddOrRemoveProductsToCompareResponse.fromJson1(
            json.decode(response.body));
      }
    } else {
      addRemoveResponse.add(AddToCompare(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: -1));
      return AddOrRemoveProductsToCompareResponse(
          addToCompare: addRemoveResponse);
    }
  }

  Future<ProductReviewDetailResponse> apiProductReviewDetail(
      String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
        method: Method.GET,
        headers: buildOnlyHeaderWithToken(userToken),
        pathUrl: AppUrl.getProductReview,
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.body != null) {
          return ProductReviewDetailResponse.fromJson(
              json.decode(response.body));
        } else {
          return ProductReviewDetailResponse(
              message: AppConstants.ERROR, status: "0");
        }
      } else {
        return ProductReviewDetailResponse(
            message: AppConstants.ERROR, status: "0");
      }
    } else {
      return ProductReviewDetailResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: "0");
    }
  }
}
