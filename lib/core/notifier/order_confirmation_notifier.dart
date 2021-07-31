import 'package:thought_factory/core/data/remote/repository/order_confirmation_repository.dart';
import 'package:thought_factory/core/data/remote/request_response/cart/get_order_by_id/CreateOrderByIdResponse.dart';
import 'package:thought_factory/core/notifier/base/base_notifier.dart';
import 'package:thought_factory/utils/app_log_helper.dart';

class OrderConfirmationNotifier extends BaseNotifier {
  final log = getLogger('OrderConfirmationNotifier');

  GetOrderByIdResponse _getOrderByIdResponse = GetOrderByIdResponse();

  //constructor
  OrderConfirmationNotifier(context, String cartResponseId) {
    //update scaffold context
    super.context = context;
    log.i("cartResponseid ---------------> $cartResponseId");
    callApiGetOrderById(cartResponseId);
  }

  OrderConfirmationRepository _orderConfirmationRepository = OrderConfirmationRepository();

  GetOrderByIdResponse get getOrderByIdResponse => _getOrderByIdResponse;

  set getOrderByIdResponse(GetOrderByIdResponse value) {
    _getOrderByIdResponse = value;
    notifyListeners();
  }

  //api: get order by id
  void callApiGetOrderById(String id) async {
    log.i('api ::: callApiGetOrderById called');
    super.isLoading = true;
    try {
      GetOrderByIdResponse response = await _orderConfirmationRepository
          .apiGetOrderByIdResponse(id);
      onNewGetOrderResponse(response);
      super.isLoading = false;
    } catch (e) {
      log.e("Error :" + e.toString());

      super.isLoading = false;
    }
  }

  //api: cart quote id
  Future<String> callApiCartQuoteId() async {
    log.i('api ::: callApiCartQuoteId called');
    super.isLoading = true;
    String response = await _orderConfirmationRepository.apiCartQuoteIdResponse().whenComplete((){
      super.isLoading = false;
    });
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  void onNewGetOrderResponse(GetOrderByIdResponse response) {
    if (response != null) {
      getOrderByIdResponse = response;
    }
  }



}