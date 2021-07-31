import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/all_url_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/basic_info/basic_info_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/add_cart_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/add_cart_item_product/request_add_cart_item_update.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_cart_list.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cart_list/response_remove_cart.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/create_order/CreateOrderRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/create_order/create_order_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/quote_id/cart_quote_id_response.dart';
import 'package:thought_factory/core/data/remote/request_response/common/country_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/add_address_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/delete_address.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/update_address_request.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_address/update_address_response.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/add_new_card_request.dart';
import 'package:thought_factory/core/data/remote/request_response/manage_payment/remove_card_response.dart';
import 'package:thought_factory/core/data/remote/request_response/product/card/PaymentCardRequest.dart';
import 'package:thought_factory/core/data/remote/request_response/product/card/PaymentCardResponse.dart';
import 'package:thought_factory/core/data/remote/request_response/sub_category/response_sub_category_list.dart';
import 'package:thought_factory/core/data/remote/request_response/termsandcondition/terms_condition_response.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/profile_image_response.dart';
import 'package:thought_factory/core/data/remote/request_response/update_profile/update_profile_response.dart';
import 'package:thought_factory/core/data/remote/request_response/user/user_detail_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/add_to_cart_request.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/add_to_cart_request.dart'
    as prefix0;
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_item_response.dart';
import 'package:thought_factory/core/data/remote/request_response/wishlist/wish_list_response.dart';
import 'package:thought_factory/core/model/item_product_model.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import '../../../../router.dart';
import 'base/base_repository.dart';

class CommonRepository extends BaseRepository {
  CommonRepository._internal();

  static final CommonRepository _singleInstance = CommonRepository._internal();

  factory CommonRepository() => _singleInstance;

  //api: getUserDetail by loginToken
  Future<UserDetailResponse> apiGetUserDetailByToken(String userToken) async {
    final response = await networkProvider.call(
        pathUrl: AppUrl.pathGetUserDetailByToken,
        method: Method.GET,
        headers: buildDefaultHeaderWithToken(userToken));
    if (response.statusCode == HttpStatus.ok) {
      return UserDetailResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return UserDetailResponse.fromJson(json.decode(response.body));
    } else {
      //need to handel network connection error
      return null;
    }
  }

  //api: getUserDetail by loginToken
  Future<ProfileImageResponse> apiGetProfileImage(String userToken) async {
    final response = await networkProvider.call(
        pathUrl: AppUrl.getProfileImage,
        method: Method.GET,
        headers: buildDefaultHeaderWithToken(userToken));
    if (response.statusCode == HttpStatus.ok) {
      log.d("111111", "111111");
      return ProfileImageResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.unauthorized) {
      log.d("111111", "22222");
      return ProfileImageResponse(message: AppConstants.ERROR, status: 0);
    } else {
      //need to handel network connection error
      log.d("111111", "33333");
      return ProfileImageResponse(message: AppConstants.ERROR, status: 0);
    }
  }

  //api remove address
  Future<DeleteAddress> apiRemoveCoupon(int addressId) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.deleteAddress + addressId.toString(),
          method: Method.DELETE,
          headers: buildDefaultHeaderWithToken(CommonNotifier().userToken));
      if (response.statusCode == HttpStatus.ok) {
        return DeleteAddress.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return DeleteAddress(message: "Error", status: 0);
      } else {
        //need to handel network connection error
        return DeleteAddress(message: "Error", status: 0);
      }
    } else {
      return DeleteAddress(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //update address
  Future<UpdateAddressResponse> apiUpdateAddress(
      UpdateAddressRequest requestParams) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.updateAddress,
          body: requestParams.toJson(),
          headers: buildDefaultHeaderWithToken(CommonNotifier().userToken));
      if (response.statusCode == HttpStatus.ok) {
        return UpdateAddressResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return UpdateAddressResponse(message: 'Error', status: 0);
      } else if (response.statusCode == HttpStatus.notFound) {
        return UpdateAddressResponse(message: 'Error', status: 0);
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return UpdateAddressResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

  //add address
  Future<AddAddressResponse> apiAddAddress(
      UpdateAddressRequest requestParams) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.addAddress,
          body: requestParams.toJson(),
          headers: buildDefaultHeaderWithToken(CommonNotifier().userToken));
      if (response.statusCode == HttpStatus.ok) {
        return AddAddressResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return AddAddressResponse(message: 'Error', status: 0);
      } else if (response.statusCode == HttpStatus.notFound) {
        return AddAddressResponse(message: 'Error', status: 0);
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return AddAddressResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

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

  // api: get create order api response
  Future<CreateOrderResponse> apiCreateOrderResponse(
      CreateOrderRequest createOrderRequest) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathCreateOrder,
          method: Method.PUT,
          body: createOrderRequest.toJson(),
          headers: buildDefaultHeaderWithToken(CommonNotifier().userToken));
//cartResponseId
      if (response != null) {
        if (response.statusCode == HttpStatus.ok) {
          String cartResponseId = json.decode(response.body);
          if (cartResponseId != null && cartResponseId.isNotEmpty) {
            return CreateOrderResponse(cartResponseId: cartResponseId);
          } else {
            return CreateOrderResponse(
                message: 'Server error wile creating order');
          }
        } else if (response.statusCode != null && response.body != null) {
          return CreateOrderResponse.fromJson(json.decode(response.body));
        } else {
          return CreateOrderResponse(message: AppConstants.ERROR);
        }
      } else {
        return CreateOrderResponse(message: AppConstants.ERROR);
      }
    }
    return CreateOrderResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
  }

  //api: apiAddItemToCart
  Future<AddToCartResponse> apiAddItemToCart(
      String userToken, ItemProduct itemProduct) async {
    log.i("Api callll --------------> $itemProduct}");
    final response = await networkProvider.call(
        method: Method.POST,
        pathUrl: AppUrl.pathAddWishListItemToCart,
        body: buildRequest(itemProduct).toJson(),
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

  AddToCartRequest buildRequest(ItemProduct itemProduct) {
    return AddToCartRequest(
        cartItem: prefix0.CartItem(
            sku: itemProduct.sku,
            qty: itemProduct.chosenQuantity,
            quoteId: CommonNotifier().quoteId));
  }

  //api: getCartQuoteId
  Future<CartQuoteIDResponse> getCartQuoteID(String userToken) async {
    final response = await networkProvider.call(
        method: Method.POST,
        pathUrl: AppUrl.pathGetCartQuoteId,
        headers: buildDefaultHeaderWithToken(userToken));

    if (response.statusCode == HttpStatus.ok) {
      String quoteId = "${json.decode(response.body)}";

      if (quoteId.isEmpty) {
        return CartQuoteIDResponse(message: 'Server error: Token is empty');
      } else {
        return CartQuoteIDResponse(quoteId: quoteId);
      }
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return CartQuoteIDResponse.fromJson(json.decode(response.body));
    } else {
      //need to handel network connection error
      return null;
    }
  }

  //api: basic info
  Future<BasicInfoResponse> getBasicInfo(String userToken) async {
    final response = await networkProvider.call(
        method: Method.GET,
        pathUrl: AppUrl.pathBasicInfo,
        headers: buildDefaultHeaderWithToken(userToken));

    if (response.statusCode == HttpStatus.ok) {
      print("${json.decode(response.body)}");
      return BasicInfoResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return null;
    } else {
      //need to handel network connection error
      return null;
    }
  }

  //api: cart item change qty
  Future<AddToCartResponse> changeCartItemQty(
      AddCartItemQtyUpdateRequest requestParams,
      String itemCartId,
      String adminToken) async {
    final response = await networkProvider.call(
        method: Method.PUT,
        pathUrl:
            '${AppUrl.pathCartItemQtyUpdate}${CommonNotifier().quoteId}/items/$itemCartId',
        body: requestParams.toJson(),
        headers: buildDefaultHeaderWithToken(adminToken));

    if (response.statusCode == HttpStatus.ok) {
      return AddToCartResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == HttpStatus.badRequest) {
      return AddToCartResponse.fromJson(json.decode(response.body));
    } else {
      //need to handel network connection error
      return null;
    }
  }

  //api: get country list & its available region
  Future<CountryListResponse> getCountriesList() async {
    final response = await networkProvider.call(
        pathUrl: AppUrl.pathCountriesList, method: Method.GET);
    if (response.statusCode == HttpStatus.ok) {
      return CountryListResponse.fromJson(json.decode(response.body));
    } else {
      //need to handel network connection error
      return null;
    }
  }

  //api: get Cart List
  Future<CartListResponse> getCartList(String userToken, String quoteId) async {
    final response = await networkProvider.call(
      method: Method.GET,
      headers: buildDefaultHeaderWithToken(userToken),
      pathUrl: AppUrl.pathCartList + quoteId,
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.body != null) {
        return CartListResponse.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  //api: add to wish list
  Future<WishListItemResponse> addToWishList(
      String userToken, String productId) async {
    final response = await networkProvider.call(
      method: Method.POST,
      headers: buildDefaultHeaderWithToken(userToken),
      pathUrl: AppUrl.pathAddToWishList + productId,
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.body != null) {
        return WishListItemResponse(success: "true");
      } else {
        return WishListItemResponse.fromJson(json.decode(response.body));
      }
    } else {
      return null;
    }
  }

  //api: remove to wish list
  Future<WishListItemResponse> removeItemFromWishList(
      String userToken, String productId) async {
    final response = await networkProvider.call(
      method: Method.DELETE,
      headers: buildOnlyHeaderWithToken(userToken),
      pathUrl: AppUrl.pathRemoveWishListItem + productId,
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.body != null) {
        return WishListItemResponse(success: "true");
      } else {
        return WishListItemResponse.fromJson(json.decode(response.body));
      }
    } else {
      return null;
    }
  }

  //api: removeCartItem by AdminToken
  Future<RemoveCartResponse> apiRemoveCartItem(String itemId) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathRemoveCart +
              CommonNotifier().quoteId +
              "/items/" +
              itemId,
          method: Method.DELETE,
          headers: buildOnlyHeaderWithToken(CommonNotifier().adminToken));

      if (response.statusCode == HttpStatus.ok) {
        bool flag = json.decode(response.body);
        if (flag == false || flag == null) {
          return RemoveCartResponse(
              message: 'Server error: CartQuoteId is empty/Invalid');
        } else {
          return RemoveCartResponse(status: flag);
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return RemoveCartResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return RemoveCartResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: removeCardItem by AdminToken
  Future<RemoveCardResponse> apiRemoveCardItem(
    RemoveCardRequest removeCardRequest,
  ) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.deleteNewCard,
          body: removeCardRequest.toJson(),
          headers: buildDefaultHeaderWithToken(CommonNotifier().userToken));

      if (response.statusCode == HttpStatus.ok) {
        return RemoveCardResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.badRequest) {
        return RemoveCardResponse(message: AppConstants.ERROR);
      } else {
        //need to handel network connection error
        return RemoveCardResponse(message: AppConstants.ERROR);
      }
    } else {
      return RemoveCardResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  Future<TermsConditionResponse> apiTermsAndCondition(
      String userToken, String id) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
        method: Method.GET,
        headers: buildOnlyHeaderWithToken(userToken),
        pathUrl: AppUrl.pathTermsAndCondition + id,
      );

      if (response.statusCode == HttpStatus.ok) {
        if (response.body != null) {
          return TermsConditionResponse.fromJson(json.decode(response.body));
        } else {
          return TermsConditionResponse(
              message: AppConstants.ERROR, statusCode: 0);
        }
      } else {
        return TermsConditionResponse(
            message: AppConstants.ERROR, statusCode: 0);
      }
    } else {
      return TermsConditionResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, statusCode: 0);
    }
  }

  Future<AllUrlListResponse> apiAllListURL() async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
        method: Method.GET,
        pathUrl: AppUrl.allListUrl,
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.body != null) {
          return AllUrlListResponse.fromJson(json.decode(response.body));
        } else {
          return AllUrlListResponse(message: AppConstants.ERROR, status: 0);
        }
      } else {
        return AllUrlListResponse(message: AppConstants.ERROR, status: 0);
      }
    } else {
      return AllUrlListResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

  //api: post Payment Information
  //build createOrderRequest()
  Future<CreateOrderResponse> apiPaymentInformation(
      CreateOrderRequest createOrderRequest) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      print("order data mowa:${createOrderRequest.toJson()}");
      final response = await networkProvider.call(
          pathUrl: AppUrl.postPaymentInformation,
          method: Method.POST,
          body: createOrderRequest.toJson(),
          headers: buildDefaultHeaderWithTokenCookie(CommonNotifier().userToken,
              CommonNotifier().cookieIdShipmentTax));
//cartResponseId
      print("response 111: $response");
      if (response != null) {
        if (response.statusCode != null &&
            response.statusCode == HttpStatus.ok) {
          String cartResponseId = json.decode(response.body);
          if (cartResponseId != null && cartResponseId.isNotEmpty) {
            return CreateOrderResponse(cartResponseId: cartResponseId);
          } else {
            return CreateOrderResponse(
                message: 'Server error wile placing order');
          }
        } else if (response.statusCode != null && response.body != null) {
          return CreateOrderResponse.fromJson(json.decode(response.body));
        } else {
          return CreateOrderResponse(message: AppConstants.ERROR);
        }
      } else {
        return CreateOrderResponse(message: AppConstants.ERROR);
      }
    }
    return CreateOrderResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
  }

  //api get sub category list
  Future<SubCategoryListResponse> apiGetSubCategoryDetail(
      String adminToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathSubCategoryList,
          method: Method.GET,
          headers: buildHeaderWithAdminToken(adminToken: adminToken));
      if (response.statusCode == HttpStatus.ok) {
        return SubCategoryListResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return SubCategoryListResponse(childrenData: null);
      } else {
        //need to handel network connection error
        return SubCategoryListResponse();
      }
    } else {
      return SubCategoryListResponse(childrenData: null);
    }
  }

  Future<PaymentCardResponse> cardPayment(
      PaymentCardRequest paymentCardRequest) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.callPayment(
          pathUrl: AppUrl.postCardPayment,
          queryParam: null,
          method: Method.POST,
          body: paymentCardRequest.toJson(),
          headers: headerContentTypeAndAcceptPayment);
      if (response != null) {
        //if (response.statusCode != null && response.statusCode == HttpStatus.ok) {
        // return response;
        if (response.body != null) {
          return PaymentCardResponse.fromJson(json.decode(response.body));
        } else {
          return null;
        }
        // } else {
        //   return null;
        // }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
