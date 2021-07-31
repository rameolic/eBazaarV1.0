import 'dart:convert';
import 'dart:io';

import 'package:thought_factory/core/data/remote/network/app_url.dart';
import 'package:thought_factory/core/data/remote/network/method.dart';
import 'package:thought_factory/core/data/remote/request_response/order/distributor_wise_list_request.dart';
import 'package:thought_factory/core/data/remote/request_response/order/distributor_wise_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/order/order_response.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_repository.dart';

class OrderRepository extends BaseRepository {
  OrderRepository._internal();

  static final OrderRepository _singleInstance = OrderRepository._internal();

  factory OrderRepository() => _singleInstance;

  Future <OrderResponse> getOrderList(String customerID, String adminToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(method: Method.GET,
          pathUrl: AppUrl.getOrderList,
          headers: buildHeaderWithAdminToken(adminToken: adminToken),
          queryParam: {
            'searchCriteria[filter_groups][0][filters][0][field]': 'customer_id',
            'searchCriteria[filter_groups][0][filters][0][condition_type]': 'eq',
            'searchCriteria[filter_groups][0][filters][0][value]': customerID,
            'searchCriteria[sortOrders][0][field]': 'created_at',
            'searchCriteria[sortOrders][0][direction]': 'DESC'
          });
      if (response.statusCode == HttpStatus.ok) {
        return OrderResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.notFound) {
        return OrderResponse(message: "Error", status: 0);
      } else {
        return OrderResponse(message: "Error", status: 0);
        //throw Exception('failed to load post');
      }
    } else {
      return OrderResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

  //api: get Distributor Wise OrderList
  Future<DistributorWiseListResponse> getDistributorWiseOrderList(
      DistributorWiseListRequest distributorWiseListRequest,
      String userToken) async {
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      final response = await networkProvider.call(
          method: Method.POST,
          pathUrl: AppUrl.getDistributionWiseOrderList,
          body: distributorWiseListRequest.toJson(),
          headers: buildDefaultHeaderWithToken(userToken));
      if (response.statusCode == HttpStatus.ok) {
        return DistributorWiseListResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == HttpStatus.unauthorized) {
        return DistributorWiseListResponse(status: 0, message: AppConstants.ERROR);
      }
      else if (response.statusCode == HttpStatus.notFound) {
        return DistributorWiseListResponse(status: 0, message: AppConstants.ERROR);
      } else {
        return null;
      }
    } else {
      return DistributorWiseListResponse(
          message: AppConstants.ERROR_INTERNET_CONNECTION, status: 0);
    }
  }

}
