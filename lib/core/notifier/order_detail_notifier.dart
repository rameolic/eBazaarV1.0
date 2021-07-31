import 'dart:collection';

import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/remote/repository/order_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/order/distributor_wise_list_request.dart';
import 'package:thought_factory/core/data/remote/request_response/order/distributor_wise_list_response.dart';
import 'package:thought_factory/core/data/remote/request_response/order/request_ordered_product_status.dart';

import 'base/base_notifier.dart';
import 'common_notifier.dart';

class OrderDetailNotifier extends BaseNotifier {
  final _repository = OrderRepository();
  DistributorWiseListResponse _orderResponse = DistributorWiseListResponse();

  DistributorWiseListResponse get orderResponse => _orderResponse;
  int _assignOrderVehicleStatusId = 0;
  Map<String, int> _productStatusList = new HashMap();

  int get assignOrderVehicleStatusId => _assignOrderVehicleStatusId;

  set assignOrderVehicleStatusId(int value) {
    _assignOrderVehicleStatusId = value;
    notifyListeners();
  }

  set orderResponse(DistributorWiseListResponse value) {
    _orderResponse = value;
    notifyListeners();
  }

  Map<String, int> get productStatusList => _productStatusList;

  set productStatusList(Map<String, int> value) {
    _productStatusList = value;
    notifyListeners();
  }

  OrderDetailNotifier(BuildContext context, String entityId) {
    super.context = context;
    apiGetDistributorOrderProductListDetails(entityId);
  }

  apiGetDistributorOrderProductListDetails(String entityId) async {
    log.i('api ::: apiGetOrderedProductList called');
    isLoading = true;
    DistributorWiseListRequest distributorWiseListRequest =
        new DistributorWiseListRequest();
    distributorWiseListRequest.orderId = entityId;

    DistributorWiseListResponse response =
        await _repository.getDistributorWiseOrderList(
            distributorWiseListRequest, CommonNotifier().userToken);
    isLoading = false;
    onGetOrderResponse(response, entityId);
  }

  onGetOrderResponse(DistributorWiseListResponse response, String orderId) async {
    if (response != null) {
      _orderResponse = response;
//      if(_orderResponse.data.orderedItemList != null && _orderResponse.data.orderedItemList.length > 0) {
//        for(int i = 0; i < _orderResponse.items.length; i++) {
//          apiGetOrderedProductStatusDetails(OrderedProductStatusDetailRequest(orderId: orderId, sellerId: ), CommonNotifier().userToken)
//        }
//      }
    }
  }

  apiGetOrderedProductStatusDetails(
      OrderedProductStatusDetailRequest orderedProductStatusDetailRequest,
      String userToken) async {
    log.i('api ::: apiGetOrderedProductStatus called');
    isLoading = true;
    DistributorWiseListRequest distributorWiseListRequest =
        new DistributorWiseListRequest();
    distributorWiseListRequest.orderId = userToken;

    DistributorWiseListResponse response =
        await _repository.getDistributorWiseOrderList(
            distributorWiseListRequest, CommonNotifier().userToken);
    isLoading = false;

  }


}
