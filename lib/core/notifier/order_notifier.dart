import 'package:flutter/src/widgets/framework.dart';
import 'package:thought_factory/core/data/local/app_shared_preference.dart';
import 'package:thought_factory/core/data/remote/repository/order_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/order/order_response.dart';
import 'package:thought_factory/utils/app_constants.dart';
import 'package:thought_factory/utils/app_network_check.dart';

import 'base/base_notifier.dart';


class OrderNotifier extends BaseNotifier {
  final _repository = OrderRepository();
  OrderResponse _orderResponse = OrderResponse();
  OrderResponse get orderResponse => _orderResponse;
  String adminToken = '';
  String userToken = '';

  set orderResponse(OrderResponse value) {
    _orderResponse = value;
    notifyListeners();
  }
  List<Items> lstOrders = List();
  OrderNotifier(BuildContext context) {
    super.context=context;
    initSetUp();

  }

  initSetUp() async {
    adminToken =  await AppSharedPreference().getAdminToken();
    userToken = await AppSharedPreference().getUserToken();
    apiGetOrderListDetails();
  }

  apiGetOrderListDetails() async {
    log.i('api ::: apiGetCustomCategoryList called');
    bool isNetworkAvail = await NetworkCheck().check();
    if (isNetworkAvail) {
      isLoading = true;
      String customerID = await AppSharedPreference().getCustomerId();
      OrderResponse response =
      await _repository.getOrderList(customerID, adminToken);
      isLoading = false;
      onGetOrderResponse(response);
    } else {
      //show error toast
      showSnackBarMessageWithContext(AppConstants.ERROR_INTERNET_CONNECTION);
    }
  }

   onGetOrderResponse(OrderResponse response) {
    if(response!=null){
      _orderResponse = response;
    }


  }
}