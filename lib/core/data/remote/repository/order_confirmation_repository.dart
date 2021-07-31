import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/get_order_by_id/CreateOrderByIdResponse.dart';
import 'package:thought_factory/core/notifier/common_notifier.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_repository.dart';

class OrderConfirmationRepository extends BaseRepository {
  OrderConfirmationRepository._internal();

  static final OrderConfirmationRepository _singleInstance = OrderConfirmationRepository._internal();

  factory OrderConfirmationRepository() => _singleInstance;

  //api: get cart total response
  Future<GetOrderByIdResponse> apiGetOrderByIdResponse(String id) async {
    bool isNetworkAvail = await NetworkCheck().check();
    print(id.toString());
    print(CommonNotifier().adminToken);
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathGetOrderById + id,
          method: Method.GET,
          headers: buildDefaultHeaderWithToken(CommonNotifier().adminToken));
      if (response.statusCode == HttpStatus.ok) {
        print(json.decode(response.body));
        return GetOrderByIdResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return null;
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return null;
    }
  }

  //api: cart quote id
  Future<String> apiCartQuoteIdResponse() async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          pathUrl: AppUrl.pathCartQuoteId,
          method: Method.POST,
          headers: buildDefaultHeaderWithToken(CommonNotifier().userToken));
      if (response.statusCode == HttpStatus.ok) {
        return "${json.decode(response.body)}";
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return json.decode(response.body);
      } else {
        //need to handel network connection error
        return null;
      }
    } else {
      return null;
    }
  }
}