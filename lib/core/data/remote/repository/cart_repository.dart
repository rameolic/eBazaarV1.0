import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cookie/request_web_form_login.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cookie/response_form_key.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/cookie/response_web_form_login.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/coupon/response_add_coupon.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/coupon/response_remove_coupon.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/set_shipping/set_shipping_request.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/set_shipping/set_shipping_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/shipping_method/shipping_method_request.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/shipping_method/shipping_method_response.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/total/cart_total_reques.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/total/cart_total_response.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_repository.dart';

class CartRepository extends BaseRepository {
  CartRepository._internal();

  static final CartRepository _singleInstance = CartRepository._internal();

  factory CartRepository() => _singleInstance;

  //api:  createCoupon by AdminToken
  Future<AddCouponResponse> apiAddCoupon(String couponCode) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      String cartQuoteId = await AppSharedPreference().getCartQuoteId();
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathAddCoupon +
              cartQuoteId +
              "/coupons/" +
              couponCode.trim(),
          method: Method.PUT,
          headers: buildDefaultHeaderWithToken(CommonNotifier().adminToken));
      if (response.statusCode == HttpStatus.ok) {
        bool flag = json.decode(response.body);
        if (flag == false || flag == null) {
          return AddCouponResponse(
              message: 'Server error: CartQuoteId is empty/Invalid');
        } else {
          return AddCouponResponse(flag: flag);
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return AddCouponResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.notFound) {
        return AddCouponResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return AddCouponResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api:  removeCoupon by AdminToken
  Future<RemoveCouponResponse> apiRemoveCoupon() async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      String cartQuoteId = await AppSharedPreference().getCartQuoteId();
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathRemoveCoupon + cartQuoteId.trim() + "/coupons",
          method: Method.DELETE,
          headers: buildDefaultHeaderWithToken(CommonNotifier().adminToken));
      if (response.statusCode == HttpStatus.ok) {
        bool flag = json.decode(response.body);
        if (flag == false || flag == null) {
          return RemoveCouponResponse(
              message: 'Server error: CartQuoteId is empty/Invalid');
        } else {
          return RemoveCouponResponse(flag: flag);
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return RemoveCouponResponse.fromJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return RemoveCouponResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: Get form key
  Future<FormKeyResponse> apiFormKey() async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.formKey, method: Method.GET);

      print("response is T:" + response.toString());
      return FormKeyResponse.fromJson(json.decode(response.body));
    }
  }

  //api: Post webFormLogin
  Future<WebFormLoginResponse> apiWebFormLogin(
      WebFormLoginRequest webFormLoginRequest) async {
    print("asdfgh : ${webFormLoginRequest.toJson()}");
    final response = await networkProvider.call(
        pathUrl: AppUrl.webFormLogin,
        method: Method.POST,
        body: webFormLoginRequest.toJson(),
        headers: buildDefaultHeaderWithXRequest());

    if (response.statusCode == HttpStatus.ok) {
      if (response != null) {
        CommonNotifier().cookieIdShipmentTax = updateCookie(response);
      }
      return WebFormLoginResponse.fromJson(json.decode(response.body));
    }
  }

  //api: estimate shipping & tax, required: request & user token
  Future<ShippingMethodResponse> apiEstimateShippingAndTax(
      ShippingMethodRequest request, String cookieId) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      if (request != null) {
        final response = await networkProvider.call(
            pathUrl: AppUrl.shippingMethods,
            method: Method.POST,
            body: request.toJson(),
            headers: buildDefaultHeaderWithTokenCookie(
                CommonNotifier().userToken, cookieId));

        if (response.statusCode == HttpStatus.ok) {
          return ShippingMethodResponse.fromJson(json.decode(response.body));
        } else if (response.statusCode == HttpStatus.unauthorized) {
          return ShippingMethodResponse.fromJson(json.decode(response.body));
        } else {
          //need to handel network connection error
          return null;
        }
      } else {
        return null;
      }
    } else {
      return ShippingMethodResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: set shipping methods
  Future<SetShippingMethodResponse> apiSetShippingMethod(
      SetShippingMethodRequest request, String cookieId) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      if (request != null) {
        final response = await networkProvider.call(
            pathUrl: AppUrl.setShippingMethods,
            method: Method.POST,
            body: request.toJson(),
            headers: buildDefaultHeaderWithTokenCookie(
                CommonNotifier().userToken, cookieId));

        if (response.statusCode == HttpStatus.ok) {
          return SetShippingMethodResponse.fromJson(json.decode(response.body));
        } else if (response.statusCode == HttpStatus.unauthorized) {
          return SetShippingMethodResponse.fromErrorJson(
              json.decode(response.body));
        } else {
          //need to handel network connection error
          return null;
        }
      } else {
        return null;
      }
    } else {
      return SetShippingMethodResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: get cart total response
  Future<CartTotalResponse> apiGetCartTotalResponse(String cookieId) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.getCartTotal,
          method: Method.GET,
          headers: buildDefaultHeaderWithTokenCookie(
              CommonNotifier().userToken, cookieId));

      if (response.statusCode == HttpStatus.ok) {
        return CartTotalResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return CartTotalResponse.fromErrorJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return CartTotalResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  //api: get cart total Information response
  //_buildCartTotalRequest()
  Future<CartTotalResponse> apiGetCartTotalInfoResponse(
      TotalInfoRequest buildTotalRequest, String cookieId) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.postTotalInformation,
          method: Method.POST,
          headers: buildDefaultHeaderWithTokenCookie(
              CommonNotifier().userToken, cookieId),
          body: buildTotalRequest.toJson());

      if (response.statusCode == HttpStatus.ok) {
        return CartTotalResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return CartTotalResponse.fromErrorJson(json.decode(response.body));
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return CartTotalResponse(message: AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

  String updateCookie(Response response) {
    String rawCookie = response.headers.values.toString();
    int index = 0;

//    print("out : " + response.headers.values.toString());
//    index = rawCookie.indexOf('PHPSESSID=');
//    int endIndex = rawCookie.indexOf('; ', index);
//    print("Expected value " + rawCookie.substring(index, endIndex));
//    return rawCookie.substring(index, endIndex);
    List<String> list = rawCookie.split(", ");
    List<String> filterList = List();
    for(int i = 0; i < list.length; i++) {
      print(">>> " + list[i].toString());
      if(list[i].contains("PHPSESSID=")) {
        filterList.add(list[i]);
      }
    }
    String finalValue = "";
    for(int i = 0; i < filterList.length; i++) {
      print("### " + filterList[i]);
      if(i > 0) {
        index = filterList[i].indexOf("PHPSESSID=");
        int endIndex = filterList[i].indexOf('; ', index);
        finalValue = filterList[i].substring(index, endIndex);
        break;
      }
    }
    print("#@# " + finalValue);
    return finalValue;
  }
}
