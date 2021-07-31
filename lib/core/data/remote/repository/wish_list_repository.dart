import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/repository/base/base_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/ShareWishListRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/ShareWishListResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/add_to_cart_request.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_item_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_response.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import '../../../../router.dart';

class WishListRepository extends BaseRepository {
  WishListRepository._internal();

  static final WishListRepository _singleInstance =
      WishListRepository._internal();

  factory WishListRepository() => _singleInstance;

  //api: getUserDetail by loginToken
  Future<WishListResponse> apiGetWishList(String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathWishList,
          method: Method.GET,
          headers: buildOnlyHeaderWithToken(userToken));
      if (response.statusCode == HttpStatus.ok) {
        log.i("Api call --------------------> ${json.decode(response.body)}");
        return WishListResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return WishListResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      //return WishListResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
      return null;
    }
  }

  // api: share wish list
  //api: apiRemoveWishListItem
  Future<ShareWishListResponse> apiShareWishList(
      String userToken, ShareWishListRequest shareWishListRequest) async {
    log.i("Api call user token ---------------> $userToken");
    final response = await networkProvider.call(
        method: Method.POST,
        pathUrl: AppUrl.pathShareWishList,
        body: shareWishListRequest.toJson(),
        headers: buildDefaultHeaderWithToken(userToken));
    log.i("Api callll --------------> ${response.body} ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      return ShareWishListResponse.fromJson(json.decode(response.body));
      // return ResponseReviewList.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.badRequest) {
      return ShareWishListResponse.fromJson(json.decode(response.body));
    } else {
      //need to handel network connection error
      return null;
    }
  }

  //api: apiRemoveWishListItem
  Future<WishListItemResponse> apiRemoveWishListItem(
      String userToken, String wishListItemId) async {
    log.i("Api call user token ---------------> $userToken");
    final response = await networkProvider.call(
        method: Method.DELETE,
        pathUrl: AppUrl.pathRemoveWishListItem + wishListItemId.trim(),
        headers: buildOnlyHeaderWithToken(userToken));
    log.i("Api callll --------------> ${response.body} ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      //return response.body;
      WishListItemResponse wishListItemResponse = WishListItemResponse();
      wishListItemResponse.success = response.body.toString();
      return wishListItemResponse;
    } else if (response.statusCode == HttpStatus.notFound) {
      return WishListItemResponse.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  //api: apiRemoveWishListItem
  Future<AddToCartResponse> apiAddWishListItemToCart(
      String userToken, AddToCartRequest addToCartRequest) async {
    log.i("Api call user token ---------------> $userToken");
    final response = await networkProvider.call(
        method: Method.POST,
        pathUrl: AppUrl.pathAddWishListItemToCart,
        body: addToCartRequest.toJson(),
        headers: buildDefaultHeaderWithToken(userToken));
    log.i("Api callll --------------> ${response.body} ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      return AddToCartResponse.fromJson(json.decode(response.body));
      // return ResponseReviewList.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.badRequest) {
      return AddToCartResponse.fromJson(json.decode(response.body));
    } else {
      //need to handel network connection error
      return null;
    }
  }
}
